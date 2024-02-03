//
//  ContentViewIPhone.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 3/02/24.
//

import SwiftUI

struct ContentViewIPhone: View {
    var body: some View {
        TabView {
            MangaListMainView()
                .tabItem {
                    Label("Lee ahora", systemImage: "book")
                }
            UserMangaCollectionView()
                .tabItem {
                    Label("Libreria", systemImage: "books.vertical")
                }
            MangasSearchView(vm: MangasSearchVM())
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentViewIPhone()
        .environment(MangaListVM.test)
        .environment(AccountVM.testLogin)
        .environment(MangaDetailVM.test)
        .environment(UserMangaCollectionVM.test)
}
