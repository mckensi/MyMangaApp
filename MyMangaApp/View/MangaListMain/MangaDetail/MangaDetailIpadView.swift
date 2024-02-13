//
//  MangaDetailIpadView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 1/02/24.
//

import SwiftUI

struct MangaDetailIpadView: View {
    
    var manga: MangaItem
    
    @Environment(MangaDetailVM.self) var vm
    @State var showAccountView = false

    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                HStack(alignment: .top) {
                    BookImage(url: manga.mainPicture)
                    VStack(alignment: .leading) {
                        BookTitleRatingAuthorIpadView(manga: manga, userManga: nil)
                        Button {
                            if manga.volumes != nil {
                                showAccountView.toggle()
                            } else {
                                Task {
                                    await vm.addMangaToLibrary(manga: manga, volumesOwned: [1], readingVolume: 1)
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
         
                BookDescriptionView(manga: manga)
                BookCollectionDetailsView(manga: manga)
                MoreBooksAuthorsGridView(authorsAndBooks: vm.authorsAndBooks, manga: manga)
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
    .onAppear {
        vm.getBooksAllAuthors(authors: manga.authors)
    }
    .sheet(isPresented: $showAccountView, content: {
        MangasVolumeSelectionView(manga: manga)
    })
    }
}

#Preview {
    MangaDetailIpadView(manga: .test)
        .environment(MangaDetailVM.test)
}
