//
//  BookTitleRatingAuthorIpadView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 1/02/24.
//

import SwiftUI

struct BookTitleRatingAuthorIpadView: View {
    let manga: MangaItem
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(manga.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            ForEach(manga.authors) { author in
                Text("\(author.firstName) \(author.lastName)")
                    .font(.title)
            }
            Text("Calificación")
                .font(.headline)
                .fontWeight(.bold)
            Text("\(Int(manga.score))/10")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
    }
}


#Preview {
    BookTitleRatingAuthorIpadView(manga: .test)
}
