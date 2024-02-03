//
//  UserMangaDetailView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia on 4/01/24.
//

import SwiftUI

struct UserMangaDetailView: View {
    @Environment(\.dismiss) var dismiss
    var vm: UserMangaDetailVM
    var deleteComplation: () -> Void
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            if let manga = vm.userManga?.manga {
                LazyVStack {
                    BookImage(url: manga.mainPicture)
                    BookTitleRatingAuthorView(manga: manga)
                    BookDescriptionView(manga: manga)
                    BookCollectionDetailsView(manga: manga)
                    MoreBooksAuthorsGridView(manga: manga)
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
        .toolbar(content: {
            Menu {
                Button(role: .destructive) {
                    Task {
                        vm.removeUserManga {
                            dismiss()
                            deleteComplation()
                        }
                    }
                } label: {
                    HStack {
                        Text("Borrar de la biblioteca")
                            .foregroundStyle(.red)
                        Spacer()
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
        label: {
            Image(systemName: "ellipsis.circle.fill")
                .imageScale(.large)
        }
        })
    }
}

#Preview {
    NavigationView(content: {
        UserMangaDetailView(vm: UserMangaDetailVM.test, deleteComplation: {})
            .environment(MangaDetailVM.test)
    })
    
    
}
