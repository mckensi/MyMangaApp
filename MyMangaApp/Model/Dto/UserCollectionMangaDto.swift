//
//  UserMangaDto.swift
//  MyMangaApp
//
//  Created by Daniel Murcia on 4/01/24.
//

import Foundation

struct UserCollectionMangaDto: Codable {
    let manga: MangaDto
    let id: String
    let readingVolume: Int
    let volumesOwned: [Int]
    let user: UserDto
    let completeCollection: Bool
}

struct UserDto: Codable {
    let id: String
}

extension UserCollectionMangaDto {
    var toPresentation: UserCollectionManga {
        UserCollectionManga(
            manga: manga.toPresentation,
            id: manga.id,
            readingVolume: readingVolume,
            volumesOwned: volumesOwned,
            user: user.toPresentation,
            completeCollection: completeCollection
        )
    }
}

extension UserDto {
    var toPresentation: UserCollection {
        UserCollection(id: id)
    }
}
