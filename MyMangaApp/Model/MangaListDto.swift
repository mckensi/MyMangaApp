//
//  MangaListDto.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import Foundation

// MARK: - MangaListDto
struct MangaListDto: Codable {
    let metadata: Metadata
    let items: [ItemDto]
}

// MARK: - ItemDto
struct ItemDto: Codable {
    let volumes: Int?
    let url, title: String
    let endDate: Date?
    let titleEnglish: String?
    let themes: [ThemeDto]
    let score: Double
    let sypnosis, background: String?
    let demographics: [DemographicDto]
    let startDate: Date
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
    let role: Role
}

enum Role: String, Codable {
    case art = "Art"
    case story = "Story"
    case storyArt = "Story & Art"
}

// MARK: - DemographicDto
struct DemographicDto: Codable {
    let id, demographic: String
}

// MARK: - GenreDto
struct GenreDto: Codable {
    let id, genre: String
}

enum Status: String, Codable {
    case currentlyPublishing = "currently_publishing"
    case finished = "finished"
}

// MARK: - ThemeDto
struct ThemeDto: Codable {
    let id, theme: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let total, page, per: Int
}

