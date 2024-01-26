//
//  BookImage.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct BookImage: View {
    let url: URL?
    var body: some View {
        AsyncImage(url: url) { cover in
            cover
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 30)
                .frame(maxWidth: 300)
        } placeholder: {
            Image(systemName: "book")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 30)
                .frame(maxWidth: 300)
                .foregroundStyle(.secondary)
        }
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BookImage(url: MangaItem.test.mainPicture)
}
