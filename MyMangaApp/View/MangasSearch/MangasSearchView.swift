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
    let items = ["Mangas", "Autores"]
    @State var selectedOption = 0
    
    var body: some View {
        @Bindable var bvm = vm
        NavigationView {
            VStack {
                SelectableHStack(items: items, selected: $selectedOption)
                    .padding(.horizontal)
                    if selectedOption == 0 {
                        ScrollView {
                            LazyVStack {
                                ForEach(vm.mangasLogic.mangas) { manga in
                                    MangaSearchItemView(manga: manga)
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

struct AuthorSearchItemView: View {
    let author: Author
    var body: some View {
        HStack {
            Image(systemName: "person.crop.square")
                .resizable()
                .frame(width: 30, height: 30)
            Text("\(author.firstName) \(author.lastName)")
                .font(.caption)
            Spacer()
        }
    }
}

struct MangaSearchItemView: View {
    let manga: MangaItem
    var body: some View {
        HStack {
            AsyncImage(url: manga.mainPicture) { cover in
                cover
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .shadow(radius: 1)
                
            } placeholder: {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
            }
            VStack(alignment: .leading) {
                Text(manga.title)
                    .font(.caption)
                Text(manga.title)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
