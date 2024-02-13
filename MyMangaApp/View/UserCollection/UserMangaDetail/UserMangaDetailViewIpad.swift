//
//  UserMangaDetailViewIpad.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/02/24.
//

import SwiftUI

struct UserMangaDetailViewIpad: View {
    var vm: UserMangaDetailVM
    var deleteComplation: () -> Void
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            if let manga = vm.userManga?.manga {
                LazyVStack {
                    HStack(alignment: .top) {
                        BookImage(url: manga.mainPicture)
                        VStack(alignment: .leading) {
                            BookTitleRatingAuthorIpadView(manga: manga, userManga: vm.userManga)
                                .padding(.top, 8)
                        }
                     
                    }
                    BookDescriptionView(manga: manga)
                    BookCollectionDetailsView(manga: manga)
                    MoreBooksAuthorsGridView(authorsAndBooks: vm.authorsAndBooks, manga: manga)
                }
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
        .userMangaToolbar(userMangaDetailVM: vm, dismissCompletion: deleteComplation)
    }
}

#Preview {
        UserMangaDetailViewIpad(vm: UserMangaDetailVM.test, deleteComplation: {})
}
