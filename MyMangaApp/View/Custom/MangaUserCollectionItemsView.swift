//
//  MangaUserCollectionItemsView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct MangaUserCollectionItemsView: View {
    var mangas: [UserMangaItem]
    var deleteComplation: () -> Void
    @Binding var showAccountView: Bool
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 190), spacing: 8)
    
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [itemAdaptativeTypes], spacing: 8) {
                ForEach(
                    mangas
                ) { manga in
                    NavigationLink(value: manga) {
                        MangaListItemView(manga: manga.toMangaItem)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationDestination(for: MangaItem.self) { manga in
            switch deviceIdiom {
            case .pad:
                MangaDetailIpadView(vm: MangaDetailVM(manga: manga))
            case .vision:
                MangaDetailIpadView(vm: MangaDetailVM(manga: manga))
            default:
                MangaDetailView(vm: MangaDetailVM(manga: manga))
            }
        }
        .navigationDestination(for: UserMangaItem.self) { manga in
            switch deviceIdiom {
            case .pad:
                UserMangaDetailViewIpad(vm: UserMangaDetailVM(id: manga.id)) {
                    deleteComplation()
                }
            case .vision:
                UserMangaDetailViewIpad(vm: UserMangaDetailVM(id: manga.id)) {
                    deleteComplation()
                }
            default:
                UserMangaDetailView(vm: UserMangaDetailVM(id: manga.id), deleteComplation: {
                    deleteComplation()
                })
            }
        }
        .navigationDestination(for: Author.self) { author in
            MangasByAuthorView(vm: MangasByAuthorVM(author: author))
        }
    }
}

#Preview {
    MangaUserCollectionItemsView(mangas: [.test], deleteComplation: {}, showAccountView: .constant(false))
}
