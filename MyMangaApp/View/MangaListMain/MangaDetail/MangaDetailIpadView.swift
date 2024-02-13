//
//  MangaDetailIpadView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 1/02/24.
//

import SwiftUI

struct MangaDetailIpadView: View {
    var vm: MangaDetailVM

    @State var showAccountView = false

    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                HStack(alignment: .top) {
                    BookImage(url: vm.manga.mainPicture)
                    VStack(alignment: .leading) {
                        BookTitleRatingAuthorIpadView(manga: vm.manga, userManga: nil)
                        Button {
                            if vm.manga.volumes != nil {
                                showAccountView.toggle()
                            } else {
                                Task {
                                    await vm.addMangaToLibrary(volumesOwned: [1], readingVolume: 1)
                                }
                            }
                        } label: {
                            AddCollectionButton()
                        }
                        #if os(visionOS)
                        .hoverEffect()
                        .buttonStyle(.bordered)
                        #else
                        .buttonStyle(.plain)
                        #endif
                    }
                }
         
                BookDescriptionView(manga: vm.manga)
                BookCollectionDetailsView(manga: vm.manga)
                MoreBooksAuthorsGridView(authorsAndBooks: vm.authorsAndBooks, manga: vm.manga)
            }
        }
        .alert("App Alert", isPresented: $bvm.showAlert) {
            
        }
    message: {
        Text(vm.alertMsg)
    }
    .alert("Manga agregado.", isPresented: $bvm.showSuccessAddedMangaAlert) {
    }
    message: {
        Text("El Manga ha sido agregado a tu colección.")
    }
    .sheet(isPresented: $showAccountView, content: {
        MangasVolumeSelectionView(manga: vm.manga)
    })
    }
}

#Preview {
    MangaDetailIpadView(vm: MangaDetailVM.test)
}
