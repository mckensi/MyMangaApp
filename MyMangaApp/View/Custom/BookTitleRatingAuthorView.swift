//
//  BookTitleRatingAuthorView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct BookTitleRatingAuthorView: View {
    let manga: MangaItem
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(manga.title)
                .font(.title)
                .fontWeight(.bold)
            ForEach(manga.authors) { author in
                Text("\(author.firstName) \(author.lastName)")
                    .font(.subheadline)
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Calificación")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("\(Int(manga.score))/10")
                        .foregroundStyle(.secondary)
                        .font(.caption2)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    BookTitleRatingAuthorView(manga: .test)
}
