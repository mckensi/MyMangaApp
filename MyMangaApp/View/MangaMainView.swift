//
//  MangaMainView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import SwiftUI

struct MangaMainView: View {
    var body: some View {
        TabView {
            MangaListMainView()
                .tabItem {
                    Label("Lee ahora", systemImage: "book")
                }
            UserCollectionView()
                .tabItem {
                    Label("Libreria", systemImage: "books.vertical")
                }
            
        }
    }
}

#Preview {
    MangaMainView()
        .environment(MangaListVM.test)
        .environment(AccountVM())
        .environment(MangaDetailVM.test)
        .environment(UserMangaCollectionVM.test)
}
