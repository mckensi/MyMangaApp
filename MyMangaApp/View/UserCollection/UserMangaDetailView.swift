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
            VStack {
                if let userManga = vm.userManga {
                    BookImage(url: userManga.manga.mainPicture)
                    BookTitleRatingAuthorView(manga: userManga.manga)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Volumenes")
                            .font(.caption)
                            .fontWeight(.bold)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(userManga.volumesOwned, id: \.self) { volume in
                                    Text("\(volume)")
                                        .font(.caption2)
                                        .foregroundStyle(userManga.readingVolume == volume ? .primary : .secondary)
                                }
                            }
                        }
                    }
                    .padding(.top, 4)
                    .padding(.horizontal)
                    Divider()
                        .padding(.top)
                        .padding(.horizontal)
                    BookDescriptionView(manga: userManga.manga)
                    Divider()
                        .padding(.horizontal)
                    BookCollectionDetailsView(manga: userManga.manga)
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
                Button("Borrar de la biblioteca", role: .destructive) {
                    Task {
                        vm.removeUserManga {
                            dismiss()
                            deleteComplation()
                        }
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
    })
}
