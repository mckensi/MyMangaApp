//
//  FilterToolbar.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct FilterToolbarAuthor: ViewModifier {
    var vm: MangasByAuthorVM
    func body(content: Content) -> some View {
        content
            .toolbar {
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
                        Button("Titulo", role: .none) {
                            vm.mangasLogic.orderByTitle()
                        }
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .imageScale(.large)
                }
            }
            
    }
}


extension View {
    func filterToolbarAuthor(mangasByAuthorVM: MangasByAuthorVM) -> some View {
        modifier(FilterToolbarAuthor(vm: mangasByAuthorVM))
    }
}
