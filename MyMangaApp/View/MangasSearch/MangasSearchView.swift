//
//  MangasSearchView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/01/24.
//

import SwiftUI

struct MangasSearchView: View {
    
    var vm: MangasSearchVM
    
    @State var textToSearch = ""
    let items:[String] = ["Mangas", "Autores"]
    @State var selectedOption = 0
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        @Bindable var bvm = vm
        NavigationStack {
            VStack {
                SelectableHStack(items: items, selected: $selectedOption)
                    .padding(.horizontal)
                    if selectedOption == 0 {
                        if vm.showWithoutResults {
                            WithoutResultsView()
                        } else {
                            ScrollView {
                                LazyVStack {
                                    ForEach(vm.mangasLogic.mangas) { manga in
                                        NavigationLink(value: manga) {
                                            MangaSearchItemView(manga: manga)
                                                .onAppear {
                                                    vm.searchMangaNextPage(idManga: manga.id)
                                                }
                                                .hoverEffect()
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .padding()
                        }
             
                    } else {
                        if vm.showWithoutResults {
                            WithoutResultsView()
                        } else {
                            ScrollView {
                                LazyVStack {
                                    ForEach(vm.mangasLogic.authors) { author in
                                        NavigationLink(value: author) {
                                            AuthorSearchItemView(author: author)
                                                .hoverEffect()
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .padding()
                        }
               
                    }
            }
            .navigationDestination(for: MangaItem.self) { manga in
                switch deviceIdiom {
                case .pad:
                    MangaDetailIPadView(vm: MangaDetailVM(manga: manga))
                case .vision:
                    MangaDetailIPadView(vm: MangaDetailVM(manga: manga))
                default:
                    MangaDetailView(vm: MangaDetailVM(manga: manga))
                }
            }
            .navigationDestination(for: Author.self) { author in
                MangasByAuthorView(vm: MangasByAuthorVM(author: author))
            }
            .searchable(text: $textToSearch)
            .onSubmit(of: .search) {
                if selectedOption == 0 {
                    vm.searchMangas(text: textToSearch, removeAll: true)
                } else {
                    vm.searchAuthors(text: textToSearch)
                }
            }
            .onChange(of: textToSearch) { oldValue, newValue in
                if newValue.isEmpty {
                    vm.clearSearch()
                    vm.showWithoutResults = false
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
        }
        .alert("App Alert", isPresented: $bvm.showAlert) {}
        message: {
            Text(vm.alertMsg)
        }
    }
}

#Preview {
    MangasSearchView(vm: MangasSearchVM(network: DataTest()))
}
