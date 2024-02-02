//
//  MangasSearchIpadView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 1/02/24.
//

import SwiftUI

struct MangasSearchIpadView: View {
    var vm: MangasSearchVM
    
    @Binding var textToSearch: String
    let items = ["Mangas", "Autores"]
    @State var selectedOption = 0
    
    var body: some View {
        @Bindable var bvm = vm
        VStack {
            SelectableHStack(items: items, selected: $selectedOption)
                .padding(.horizontal)
            if selectedOption == 0 {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.mangasLogic.mangas) { manga in
                            MangaSearchItemIpadView(manga: manga)
                                .onAppear {
                                    vm.searchMangaNextPage(idManga: manga.id)
                                }
                        }
                    }
                }
                .padding()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.mangasLogic.authors) { author in
                            AuthorSearchItemView(author: author)
                        }
                    }
                }
                .padding()
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
            vm.searchMangas(text: textToSearch, removeAll: true)
        } else {
            vm.searchAuthors(text: textToSearch)
        }
    }
    }
}

#Preview {
    MangasSearchIpadView(vm: MangasSearchVM(network: DataTest()), textToSearch: .constant(""))
}
