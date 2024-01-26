//
//  BookCollectionDetailsView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct BookCollectionDetailsView: View {
    let manga: MangaItem
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                VStack(spacing: 10) {
                    Text("Género".uppercased())
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.secondary)
                    Text(manga.genres.first?.genre ?? "")
                }
                VStack(spacing: 10) {
                    Text("Volumenes".uppercased())
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.secondary)
                    Text("\(manga.volumes ?? 1)")
                }
                VStack(spacing: 10) {
                    Text("Capítulos".uppercased())
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.secondary)
                    Text("\(manga.chapters ?? 1)")
                }
                VStack(spacing: 10) {
                    Text("Temas".uppercased())
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.secondary)
                    ForEach(manga.themes) { theme in
                        Text(theme.theme)
                    }
                }
            }
            .padding()
        }
    }
}


#Preview {
    BookCollectionDetailsView(manga: .test)
}
