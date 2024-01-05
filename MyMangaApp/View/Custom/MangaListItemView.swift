//
//  MangaListItemView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia on 4/01/24.
//

import SwiftUI

struct MangaListItemView: View {
    var manga: MangaItem
    var body: some View {
        VStack {
            AsyncImage(url: manga.mainPicture) { cover in
                cover
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
            } placeholder: {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .frame(width: 140, height: 240)
        .padding()
    }
}

#Preview {
    MangaListItemView(manga: MangaItem.test)
}
