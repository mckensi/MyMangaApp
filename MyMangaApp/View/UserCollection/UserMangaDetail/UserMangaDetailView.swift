//
//  UserMangaDetailView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia on 4/01/24.
//

import SwiftUI

struct UserMangaDetailView: View {
    var vm: UserMangaDetailVM
    var deleteComplation: () -> Void
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            if let manga = vm.userManga?.manga {
                LazyVStack {
                    BookImage(url: manga.mainPicture)
                    BookTitleRatingAuthorView(manga: manga)
                    if let userManga = vm.userManga {
                        MyVolumesView(userManga: userManga)
                    }
                    BookDescriptionView(manga: manga)
                    BookCollectionDetailsView(manga: manga)
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
    NavigationView(content: {
        UserMangaDetailView(vm: UserMangaDetailVM.test, deleteComplation: {})
            .environment(MangaDetailVM.test)
    })
}
