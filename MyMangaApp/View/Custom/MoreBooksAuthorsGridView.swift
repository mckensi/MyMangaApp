//
//  MoreBooksAuthorsGridView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct MoreBooksAuthorsGridView: View {
    
    let gridItem = GridItem(.adaptive(minimum: 280))
    @Environment(MangaDetailVM.self) var vm
    let manga: MangaItem
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(vm.authorsAndBooks) { authorAndManga in
                NavigationLink(value: authorAndManga.author) {
                    HStack {
                        Text("Mas de \(authorAndManga.author.firstName) \(authorAndManga.author.lastName)")
                            .font(.headline)
                        Image(systemName: "chevron.right")
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    }
            
                }
                .tint(.black)
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [gridItem], spacing: 20) {
                        ForEach(
                            authorAndManga.mangas
                        ) { manga in
                            NavigationLink(value: manga) {
                                MangaListItemView(showDescription: true, manga: manga)
                            }
                        }
                    }
                }
                .tint(.black)
            }
          
   
        }
        .padding(.horizontal)
    }
}

#Preview {
    MoreBooksAuthorsGridView(manga: .test)
        .environment(MangaDetailVM.test)
}
