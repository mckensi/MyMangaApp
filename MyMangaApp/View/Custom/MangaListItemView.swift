//
//  MangaListItemView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia on 4/01/24.
//

import SwiftUI

struct MangaListItemView: View {
    var showDescription: Bool = false
    var manga: MangaItem
    var body: some View {
        VStack {
            AsyncImage(url: manga.mainPicture) { cover in
                cover
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFill()
                    .frame(width: 160, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
            } placeholder: {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            if showDescription {
                VStack(alignment: .leading) {
                    Text(manga.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    HStack {
                        Text("\(manga.authors.first?.firstName ?? "") \(manga.authors.first?.lastName ?? "")")
                            .font(.caption)
                        .foregroundStyle(.secondary)
                        Spacer()
                    }
                }
           
            }
        }
        .frame(width: 160, height: 280)
        .padding()
    }
}

#Preview {
    MangaListItemView(manga: MangaItem.test)
}
