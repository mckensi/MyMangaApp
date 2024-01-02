//
//  UserMangaCollectionRequest.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

struct UserMangaCollectionRequest: Codable {
    var manga: Int
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
}
