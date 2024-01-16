//
//  MangasByCategoryView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/01/24.
//

import SwiftUI

struct MangasByCategoryView: View {
    var vm: MangasByCategoryVM
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 240))
    
    var body: some View {
        ScrollView(.vertical) {
            LazyHGrid(rows: [itemAdaptativeTypes], spacing: 20) {
                ForEach(
                    vm.mangasLogic.mangas
                ) { manga in
                    NavigationLink(value: manga) {
                        MangaListItemView(manga: manga)
                    }
                }
            }
        }
        .navigationTitle(vm.genre)
    }
}

#Preview {
    NavigationView {
        MangasByCategoryView(vm: MangasByCategoryVM.test)
    }
}
