//
//  MangaList.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import Foundation

// MARK: - ItemDto
struct MangaItem: Identifiable, Hashable {
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
    let titleJapanese: String
    let status: String
    let mainPicture: URL?
    let genres: [Genre]
    let id: Int
    let chapters: Int?
    let authors: [Author]
}

// MARK: - AuthorDto
struct Author: Identifiable, Hashable {
    let id, lastName, firstName: String
    let role: String
}

// MARK: - Demographic
struct Demographic: Identifiable, Hashable {
    let id, demographic: String
}

// MARK: - Genre
struct Genre: Identifiable, Hashable {
    let id, genre: String
}

// MARK: - ThemeDto
struct Theme: Identifiable, Hashable {
    let id, theme: String
}

