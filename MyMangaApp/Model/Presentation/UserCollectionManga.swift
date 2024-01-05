//
//  UserCollectionManga.swift
//  MyMangaApp
//
//  Created by Daniel Murcia on 4/01/24.
//

import Foundation

struct UserCollectionManga: Identifiable, Hashable {
    let manga: MangaItem
    let id: Int
    let readingVolume: Int
    let volumesOwned: [Int]
    let user: UserCollection
    let completeCollection: Bool
}

struct UserCollection: Identifiable, Hashable {
    let id: String
}
