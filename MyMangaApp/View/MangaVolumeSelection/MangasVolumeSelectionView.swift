//
//  MangaVolumeSelectionView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 27/01/24.
//

import SwiftUI

struct MangasVolumeSelectionView: View {
    let manga: MangaItem
    
    var vm: MangasVolumeSelectionVM = MangasVolumeSelectionVM()
    @Environment(MangaDetailVM.self) var detailVm
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        @Bindable var bvm = detailVm
        NavigationView(content: {
            List {
                VolumesSelectionList(manga: manga, vm: vm)
                Section {
                    VStack(alignment: .leading) {
                        Text("Que volumen estas leyendo?")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                        VolumeReadingListView(vm: vm, volumes: manga.volumes ?? 0)
                    }
                }
                Button("Añadir", role: .none) {
                    if vm.isEnabledButton() {
                        Task {
                            await detailVm.addMangaToLibrary(
                                manga: manga,
                                volumesOwned: vm.mangasLogic.mangasSelected, readingVolume: vm.mangasLogic.mangaReading ?? 1
                            )
                        }
                    }
                }
                .tint(.red)
                .disabled(!vm.isEnabledButton())
            }
            .navigationTitle("Volumenes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "xmark")
                        .resizable()
                        .symbolVariant(.circle)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            dismiss()
                        }
                        .hoverEffect()
                }
            }
        })
        .alert("Manga agregado.", isPresented: $bvm.showSuccessAddedMangaAlert) {
            Button("Aceptar", role: .none) {
                dismiss()
            }
        }
    }
}

#Preview {
    MangasVolumeSelectionView(manga: .test)
        .environment(MangaDetailVM.test)
}

struct VolumeReadingListView: View {
    var vm: MangasVolumeSelectionVM
    let volumes: Int
    
    var body: some View {
        VStack {
            ForEach(1..<(volumes) + 1, id: \.self) { volume in
                VStack {
                    HStack {
                        Text("\(volume)")
                        Spacer()
                        Button {
                            vm.selectReadingVolume(volume: volume)
                            if !vm.mangasLogic.mangasSelected.contains(volume) {
                                vm.addVolume(volume: volume)
                            }
                        } label: {
                            Image(systemName: vm.mangasLogic.mangaReading == volume ? "checkmark.circle.fill" : "circle")
                        }
                        .hoverEffect()
                        .buttonStyle(.plain)
                    }
                    if volume != volumes {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.primary.opacity(0.1))
                    }
                }
            }
        }
    }
}

struct VolumesSelectionList: View {
    let manga: MangaItem
    var vm: MangasVolumeSelectionVM
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Que volumenes quieres?")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                HStack {
                    Spacer()
                    Button(role: .none) {
                        print()
                    } label: {
                        Text("Seleccionar todos")
                            .font(.caption)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.trailing)
                            .padding(.bottom, 30)
                            .onTapGesture {
                                vm.selectAllVolumes(volumes: manga.volumes ?? 1)
                            }
                    }
                }
                VolumesListView(vm: vm, volumes: manga.volumes ?? 0)
            }
        }
    }
}

struct VolumesListView: View {
    var vm: MangasVolumeSelectionVM
    let volumes: Int
    var body: some View {
        VStack {
            ForEach(1..<(volumes) + 1, id: \.self) { volume in
                VStack {
                    HStack {
                        Text("\(volume)")
                        Spacer()
                        Button {
                            vm.addVolume(volume: volume)
                        } label: {
                            Image(systemName: vm.mangasLogic.mangasSelected.contains(volume) ? "checkmark.circle.fill" : "circle")
                        }
                        .hoverEffect()
                        .buttonStyle(.plain)
                    }
                    if volume != volumes {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.primary.opacity(0.1))
                    }
                }
            }
        }
    }
}
