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
                }
            }
        }
        .navigationTitle(vm.genre)
        .toolbar(content: {
            Menu {
                Section("Temas") {
                    ForEach(vm.mangasLogic.getAllThemes()) { theme in
                        Button(theme.theme, role: theme == vm.mangasLogic.themeFilter ? .destructive : .none) {
                            vm.mangasLogic.applyFilterByTheme(theme: theme)
                        }
                    }
                }
                Section("Demografías") {
                    ForEach(vm.mangasLogic.getAllDemographics()) { demographic in
                        Button(demographic.demographic, role: demographic == vm.mangasLogic.demographicFilter ? .destructive : .none) {
                            vm.mangasLogic.applyFilterByDemographic(demographic: demographic)
                        }
                    }
                }
                Section("Ordernar") {
                    Button("Titulo", role: vm.mangasLogic.orderedByTitle ? .destructive : .none) {
                        vm.mangasLogic.orderByTitle()
                    }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .imageScale(.large)
            }

        })
        
    }
}

#Preview {
    NavigationView {
        MangasByCategoryView(vm: MangasByCategoryVM.test)
    }
}
