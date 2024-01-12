//
//  MangaAuthor.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 10/01/24.
//

import Foundation

struct MangaAuthor: Identifiable{
    let id: UUID = UUID()
    let author: Author
    let mangas: [MangaItem]
}
