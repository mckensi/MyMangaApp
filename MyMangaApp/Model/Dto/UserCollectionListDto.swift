//
//  UserCollectionListDto.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 29/12/23.
//

import Foundation

// MARK: - UserCollectionListDto
struct UserCollectionListDto: Codable {
    let user: UserCollectionDto
    let volumesOwned: [Int]
    let completeCollection: Bool
    let readingVolume: Int
    let manga: ItemDto
    let id: String
}

// MARK: - User
struct UserCollectionDto: Codable {
    let id: String
}

