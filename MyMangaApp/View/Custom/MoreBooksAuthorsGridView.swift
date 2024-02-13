//
//  MoreBooksAuthorsGridView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct MoreBooksAuthorsGridView: View {
    
    let gridItem = GridItem(.adaptive(minimum: 280))
    var authorsAndBooks: [MangaAuthor]
    let manga: MangaItem
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(authorsAndBooks) { authorAndManga in
                NavigationLink(value: authorAndManga.author) {
                    HStack {
                        Text("Mas de \(authorAndManga.author.firstName) \(authorAndManga.author.lastName)")
                            .font(.headline)
                        Image(systemName: "chevron.right")
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    }
                }
                .buttonStyle(.plain)
                .hoverEffect()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [gridItem], spacing: 20) {
                        ForEach(
                            authorAndManga.mangas
                        ) { manga in
                            NavigationLink(value: manga) {
                                MangaListItemView(showDescription: true, manga: manga)
                            }
                            .buttonStyle(.plain)
                            .hoverEffect()
                        }
                    }
                }
                .tint(.primary)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MoreBooksAuthorsGridView(authorsAndBooks: [], manga: .test)
        .environment(MangaDetailVM.test)
}
