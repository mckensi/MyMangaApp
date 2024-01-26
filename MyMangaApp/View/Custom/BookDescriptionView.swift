//
//  BookDescriptionView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct BookDescriptionView: View {
    let manga: MangaItem
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Descripción")
                .font(.headline)
            Text(manga.sypnosis ?? "")
        }
        .padding()
    }
}
#Preview {
    BookDescriptionView(manga: .test)
}
