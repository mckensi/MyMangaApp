//
//  BookCollectionDetailsView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct BookCollectionDetailsView: View {
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    
    let manga: MangaItem
    var body: some View {
        switch deviceIdiom {
        case .pad:
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 20) {
                    VStack(spacing: 10) {
                        Text("Género".uppercased())
                            .bold()
                            .foregroundStyle(.secondary)
                        Text(manga.genres.first?.genre ?? "")
                            .font(.callout)
                    }
                    Divider()
                    VStack(spacing: 10) {
                        Text("Volumenes".uppercased())
                            .bold()
                            .foregroundStyle(.secondary)
                        Text("\(manga.volumes ?? 1)")
                            .font(.callout)
                    }
                    Divider()
                    VStack(spacing: 10) {
                        Text("Capítulos".uppercased())
                            .bold()
                            .foregroundStyle(.secondary)
                        Text("\(manga.chapters ?? 1)")
                            .font(.callout)
                    }
                    Divider()
                    VStack(spacing: 10) {
                        Text("Temas".uppercased())
                            .bold()
                            .foregroundStyle(.secondary)
                        ForEach(manga.themes) { theme in
                            Text(theme.theme)
                                .font(.callout)
                        }
                    }
                    Divider()
                }
                .frame(maxHeight: 130)
                .padding()
            }
        default:
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 20) {
                    VStack(spacing: 10) {
                        Text("Género".uppercased())
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(.secondary)
                        Text(manga.genres.first?.genre ?? "")
                            .font(.caption2)
                    }
                    Divider()
                    VStack(spacing: 10) {
                        Text("Volumenes".uppercased())
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(.secondary)
                        Text("\(manga.volumes ?? 1)")
                            .font(.caption2)
                    }
                    Divider()
                    VStack(spacing: 10) {
                        Text("Capítulos".uppercased())
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(.secondary)
                        Text("\(manga.chapters ?? 1)")
                            .font(.caption2)
                    }
                    Divider()
                    VStack(spacing: 10) {
                        Text("Temas".uppercased())
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(.secondary)
                        ForEach(manga.themes) { theme in
                            Text(theme.theme)
                                .font(.caption2)
                        }
                    }
                    Divider()
                }
                .frame(maxHeight: 100)
                .padding()
            }
        }
       
    }
}


#Preview {
    BookCollectionDetailsView(manga: .test)
}
