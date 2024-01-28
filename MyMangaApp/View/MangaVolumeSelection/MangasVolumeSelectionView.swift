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
                            }
                        }
                        VolumesListView(vm: vm, volumes: manga.volumes ?? 0)
                    }
                }
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
            }
        })
        .alert("Manga agregado.", isPresented: $bvm.showSuccessAddedMangaAlert) {
            Button("Aceptar", role: .none) {
                dismiss()
            }
        }
        message: {
            Text("El Manga ha sido agregado a tu colección.")
        }
        
    }
}

#Preview {
    MangasVolumeSelectionView(manga: .test)
        .environment(MangaDetailVM.test)
}

struct VolumesListView: View {
    var vm: MangasVolumeSelectionVM
    let volumes: Int
    var body: some View {
        VStack {
            ForEach(1..<(volumes) + 1) { volume in
                VStack {
                    HStack {
                        Text("\(volume)")
                        Spacer()
                        Image(systemName: vm.mangasLogic.mangasSelected.contains(volume) ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                vm.addVolume(volume: volume)
                            }
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

struct VolumeReadingListView: View {
    var vm: MangasVolumeSelectionVM
    let volumes: Int
    
    var body: some View {
        VStack {
            ForEach(1..<(volumes) + 1) { volume in
                VStack {
                    HStack {
                        Text("\(volume)")
                        Spacer()
                        Image(systemName: vm.mangasLogic.mangaReading == volume ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                vm.selectReadingVolume(volume: volume)
                            }
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
