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
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            LazyVStack {
                BookImage(url: manga.mainPicture)
                BookTitleRatingAuthorView(manga: manga)
                AddCollectionButton(manga: manga)
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
    .navigationDestination(for: MangaItem.self) { manga in
        MangaDetailView(manga: manga)
    }
    .navigationDestination(for: Author.self) { author in
        MangasByAuthorView(vm: MangasByAuthorVM(author: author))
    }
    }
}

#Preview {
    MangaDetailView(manga: .test)
        .environment(MangaDetailVM.test)
}
