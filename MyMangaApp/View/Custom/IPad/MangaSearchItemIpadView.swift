//
//  MangaSearchItemIpadView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 1/02/24.
//

import SwiftUI

struct MangaSearchItemIpadView: View {
    let manga: MangaItem
    var body: some View {
        HStack {
            AsyncImage(url: manga.mainPicture) { cover in
                cover
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .shadow(radius: 1)
                
            } placeholder: {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 120)
            }
            VStack(alignment: .leading) {
                Text(manga.title)
                    .font(.caption)
                Text(manga.authors.first?.getFullName() ?? "")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text("\(Int(manga.score))/10")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text("Volumenes: \(manga.volumes ?? 1)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    MangaSearchItemIpadView(manga: .test)
}
