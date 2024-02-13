//
//  MyVolumesViewIPad.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/02/24.
//

import SwiftUI

struct MyVolumesViewIPad: View {
    let userManga: UserCollectionManga
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 20), spacing: 4)
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("Volumenes adquiridos")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            LazyVGrid(columns: [itemAdaptativeTypes], alignment: .leading, content: {
                    ForEach(userManga.volumesOwned , id: \.self) { volume in
                        Text("\(volume)")
                            .fontWeight(volume == userManga.readingVolume ? .bold : .light)
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .frame(width: 20)
                    }
                })
            
          
        }
    }
}

#Preview {
    MyVolumesViewIPad(userManga: UserCollectionManga.preview)
}
