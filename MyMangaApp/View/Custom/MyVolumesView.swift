//
//  MyVolumesView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/02/24.
//

import SwiftUI

struct MyVolumesView: View {
    let userManga: UserCollectionManga
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 20), spacing: 4)
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Volumenes adquiridos")
                    .font(.caption)
                    .fontWeight(.bold)
                Spacer()
            }
            LazyVGrid(columns: [itemAdaptativeTypes], content: {
                ForEach(userManga.volumesOwned , id: \.self) { volume in
                    Text("\(volume)")
                        .fontWeight(volume == userManga.readingVolume ? .bold : .light)
                        .foregroundStyle(.secondary)
                        .font(.caption2)
                        .frame(width: 20)
                }
            })
        }
    }
}

#Preview {
    MyVolumesView(userManga: UserCollectionManga.preview)
}
