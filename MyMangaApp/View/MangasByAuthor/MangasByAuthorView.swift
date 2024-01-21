//
//  MangasByAuthorView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/01/24.
//

import SwiftUI

struct MangasByAuthorView: View {
    var vm: MangasByAuthorVM
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
                }
            }
        }
        .navigationTitle(vm.author.firstName)
    }
}

#Preview {
    NavigationView {
        MangasByCategoryView(vm: MangasByCategoryVM.test)
    }
}
