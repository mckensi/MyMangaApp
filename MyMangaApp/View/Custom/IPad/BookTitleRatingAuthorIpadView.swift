//
//  BookTitleRatingAuthorIpadView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 1/02/24.
//

import SwiftUI

struct BookTitleRatingAuthorIpadView: View {
    let manga: MangaItem
    let userManga: UserCollectionManga?
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
                .padding(.top, 20)
            Text("\(Int(manga.score))/10")
                .foregroundStyle(.secondary)
                .font(.subheadline)
            if let userManga = userManga {
                MyVolumesViewIPad(userManga: userManga)
                    .padding(.top, 8)
            }
   
        }
    }
}


#Preview {
    BookTitleRatingAuthorIpadView(manga: .test, userManga: .preview)
}
