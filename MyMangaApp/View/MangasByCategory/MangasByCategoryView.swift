//
//  MangasByCategoryView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/01/24.
//

import SwiftUI

struct MangasByCategoryView: View {
    var vm: MangasByCategoryVM
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 190), spacing: 8)
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [itemAdaptativeTypes], spacing: 8) {
                ForEach(
                    vm.mangasLogic.mangas
                ) { manga in
                    NavigationLink(value: manga) {
                        MangaListItemView(manga: manga)
                            .onAppear {
                                vm.getNextPage(idManga: manga.id)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle(vm.genre)
        .filterToobarCategory(mangasByCategoryVM: vm)
    }
}

#Preview {
    NavigationView {
        MangasByCategoryView(vm: MangasByCategoryVM.test)
    }
}
