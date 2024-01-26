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
        VStack(alignment: .center) {
            Text(manga.title)
                .font(.title2)
                .fontWeight(.bold)
            ForEach(manga.authors) { author in
                Text("\(author.firstName) \(author.lastName)")
            }
            Text("Calificación: \(Int(manga.score))/10")
                .foregroundStyle(.secondary)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    BookTitleRatingAuthorView(manga: .test)
}
