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
                VolumesSelectionListView(manga: manga, vm: vm)
                Section {
                    VolumeReadingListView(vm: vm, volumes: manga.volumes ?? 0)
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
