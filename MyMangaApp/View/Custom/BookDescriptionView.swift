//
//  BookDescriptionView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct BookDescriptionView: View {
    let manga: MangaItem
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch deviceIdiom {
            case .pad:
                HStack {
                    Text("Descripción")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
    
                Text(manga.sypnosis ?? "")
                    .font(.callout)
            default:
                HStack {
                    Text("Descripción")
                        .fontWeight(.bold)
                    Spacer()
                }
                Text(manga.sypnosis ?? "")
                    .font(.caption)
            }
        }
        .padding()
    }
}
#Preview {
    BookDescriptionView(manga: .test)
}
