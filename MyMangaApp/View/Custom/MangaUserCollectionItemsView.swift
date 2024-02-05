//
//  MangaUserCollectionItemsView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct MangaUserCollectionItemsView: View {
    var mangas: [MangaItem]
    var deleteComplation: () -> Void
    @Binding var showAccountView: Bool
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 190), spacing: 8)
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [itemAdaptativeTypes], spacing: 8) {
                ForEach(
                    mangas
                ) { manga in
                    NavigationLink(value: manga) {
                        MangaListItemView(manga: manga)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationDestination(for: MangaItem.self) { manga in
            UserMangaDetailView(vm: UserMangaDetailVM(id: manga.id), deleteComplation: {
                deleteComplation()
            })
        }
    }
}

#Preview {
    MangaUserCollectionItemsView(mangas: [MangaItem.test], deleteComplation: {}, showAccountView: .constant(false))
}
