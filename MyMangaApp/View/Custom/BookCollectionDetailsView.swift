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
            HStack(alignment: .top, spacing: 20) {
                VStack(spacing: 10) {
                    Text("Género".uppercased())
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.secondary)
                    Text(manga.genres.first?.genre ?? "")
                        .font(.caption2)
                }
                Divider()
                VStack(spacing: 10) {
                    Text("Volumenes".uppercased())
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.secondary)
                    Text("\(manga.volumes ?? 1)")
                        .font(.caption2)
                }
                Divider()
                VStack(spacing: 10) {
                    Text("Capítulos".uppercased())
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.secondary)
                    Text("\(manga.chapters ?? 1)")
                        .font(.caption2)
                }
                Divider()
                VStack(spacing: 10) {
                    Text("Temas".uppercased())
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.secondary)
                    ForEach(manga.themes) { theme in
                        Text(theme.theme)
                            .font(.caption2)
                    }
                }
                Divider()
            }
            .frame(maxHeight: 100)
            .padding()
        }
    }
}


#Preview {
    BookCollectionDetailsView(manga: .test)
}
