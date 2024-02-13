//
//  UserMangaItem.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/02/24.
//

import Foundation

// MARK: - MangaItem
struct UserMangaItem: Identifiable, Hashable {
    let volumes: Int?
    let url: URL?
    let title: String
    let endDate: String?
    let titleEnglish: String?
    let themes: [Theme]
    let score: Double
    let sypnosis, background: String?
    let demographics: [Demographic]
    let startDate: String?
    let titleJapanese: String?
    let status: String
    let mainPicture: URL?
    let genres: [Genre]
    let id: Int
    let chapters: Int?
    let authors: [Author]
}

