//
//  ContentView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import SwiftUI

struct MangaListMainView: View {
    
    @Environment(MangaListVM.self) var vm
    @State var showAccountView = false
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 240))
    var body: some View {
        @Bindable var bvm = vm
        
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(
                        vm.mangasLogic.getGenres(
                            mangas: vm.mangasLogic.mangas
                        )
                    ) { genre in
                        HStack {
                            Text(genre.genre)
                                .font(.title2)
                            .bold()
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [itemAdaptativeTypes], spacing: 20) {
                                ForEach(
                                    vm.mangasLogic.getMangasByGenre(
                                        genre: genre.genre
                                    )
                                ) { manga in
                                    NavigationLink(value: manga) {
                                        MangaListItemView(manga: manga)
                                    }
                                }
                            }
                        }
                     
                    }

                }
                .padding()
            }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "person")
                    .font(.title)
                    .onTapGesture {
                        showAccountView.toggle()
                    }
            }
        }
        .navigationDestination(for: MangaItem.self) { manga in
            MangaDetailView(manga: manga)
        }
        }
        .navigationTitle("Librería")
        .alert("App Alert", isPresented: $bvm.showAlert) {}
        message: {
            Text(vm.alertMsg)
        }
        .sheet(isPresented: $showAccountView, content: {
            AccountView()
        })
    }
    
}

#Preview {
    MangaListMainView()
        .environment(MangaListVM.test)
        .environment(AccountVM())
        .environment(MangaDetailVM.test)
}
