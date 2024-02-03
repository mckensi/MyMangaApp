//
//  MangaDetailView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import SwiftUI

struct MangaDetailView: View {
    
    var manga: MangaItem
    
    @Environment(MangaDetailVM.self) var vm
    @State var showAccountView = false
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            LazyVStack {
                BookImage(url: manga.mainPicture)
                BookTitleRatingAuthorView(manga: manga)
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
                .buttonStyle(.plain)
                .hoverEffect()
                BookDescriptionView(manga: manga)
                BookCollectionDetailsView(manga: manga)
                MoreBooksAuthorsGridView(manga: manga)
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
    MangaDetailView(manga: .test)
        .environment(MangaDetailVM.test)
}
