//
//  MangasSearchIpadView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 1/02/24.
//

import SwiftUI

struct MangasSearchIPadView: View {
    var vm: MangasSearchVM
    
    @Binding var textToSearch: String
    let items:[String] = ["Mangas", "Autores"]
    @State var selectedOption = 0
    
    var body: some View {
        @Bindable var bvm = vm
        VStack {
            SelectableHStack(items: items, selected: $selectedOption)
                .padding(.horizontal)
            if selectedOption == 0 {
                if vm.mangasLogic.mangas.isEmpty {
                    WithoutResultsView()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(vm.mangasLogic.mangas) { manga in
                                NavigationLink(value: manga) {
                                    MangaSearchItemIpadView(manga: manga)
                                        .onAppear {
                                            vm.searchMangaNextPage(idManga: manga.id)
                                        }
                                }
                                #if !os(visionOS)
                                .buttonStyle(.plain)
                                #endif
                              
                            }
                        }
                    .padding()
                    }
                }
                
            } else {
                if vm.mangasLogic.authors.isEmpty {
                    WithoutResultsView()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(vm.mangasLogic.authors) { author in
                                NavigationLink(value: author) {
                                    AuthorSearchItemView(author: author)
                                }
                                #if !os(visionOS)
                                .buttonStyle(.plain)
                                #endif
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onChange(of: textToSearch) { oldValue, newValue in
            if newValue.isEmpty {
                vm.clearSearch()
            }
        }
        .onChange(of: selectedOption) { oldValue, newValue in
            if textToSearch != "" {
                if newValue == 0 {
                    if vm.mangasLogic.mangas.isEmpty {
                        vm.searchMangas(text: textToSearch, removeAll: true)
                    }
                } else {
                    if vm.mangasLogic.authors.isEmpty {
                        vm.searchAuthors(text: textToSearch)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Busqueda")
        .alert("App Alert", isPresented: $bvm.showAlert) {}
    message: {
        Text(vm.alertMsg)
    }
    .onAppear {
        if selectedOption == 0 {
            if !textToSearch.isEmpty {
                vm.searchMangas(text: textToSearch, removeAll: true)
            }
     
        } else {
            if !textToSearch.isEmpty {
                vm.searchAuthors(text: textToSearch)
            }
        }
    }
    }
}

#Preview {
    MangasSearchIPadView(vm: MangasSearchVM(network: DataTest()), textToSearch: .constant("s"))
}
