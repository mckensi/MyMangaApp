//
//  MangaDetailView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import SwiftUI

struct MangaDetailView: View {
    
    var vm: MangaDetailVM
    
    @State var showAccountView = false
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            LazyVStack {
                BookImage(url: vm.manga.mainPicture)
                BookTitleRatingAuthorView(manga: vm.manga)
                AddButtonView(showAccountView: $showAccountView, manga: vm.manga, vm: vm)
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
    MangaDetailView(vm: .test)
}
