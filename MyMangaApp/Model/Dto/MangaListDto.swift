//
//  MangaListDto.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import Foundation

// MARK: - MangaListDto
struct MangaListDto: Codable {
    let metadata: MetadataDto
    let items: [ItemDto]
}

// MARK: - ItemDto
struct ItemDto: Codable {
    let volumes: Int?
    let url, title: String
    let endDate: String?
    let titleEnglish: String?
    let themes: [ThemeDto]
    let score: Double
    let sypnosis, background: String?
    let demographics: [DemographicDto]
    let startDate: String?
    let titleJapanese: String
    let status: String
    let mainPicture: String
    let genres: [GenreDto]
    let id: Int
    let chapters: Int?
    let authors: [AuthorDto]
}

// MARK: - AuthorDto
struct AuthorDto: Codable {
    let id, lastName, firstName: String
    let role: String
}

// MARK: - DemographicDto
struct DemographicDto: Codable {
    let id, demographic: String
}

// MARK: - GenreDto
struct GenreDto: Codable {
    let id, genre: String
}

// MARK: - ThemeDto
struct ThemeDto: Codable {
    let id, theme: String
}

extension ItemDto {
    var toPresentation: MangaItem {
        MangaItem(
            volumes: volumes, 
            url: URL(string: url),
            title: title,
            endDate: endDate,
            titleEnglish: titleEnglish,
            themes: themes.map { Theme(id: $0.id, theme: $0.theme) },
            score: score,
            sypnosis: sypnosis,
            background: background,
            demographics: demographics.map { Demographic(id: $0.id, demographic: $0.demographic)},
            startDate: startDate,
            titleJapanese: titleJapanese,
            status: status,
            mainPicture: URL(string: mainPicture.trimmingCharacters(in: CharacterSet(charactersIn: "\""))),
            genres: genres.map { Genre(id: $0.id, genre: $0.genre) },
            id: id,
            chapters: chapters,
            authors: authors.map { Author(id: $0.id, lastName: $0.lastName, firstName: $0.firstName, role: $0.role) }
        )
    }
}
