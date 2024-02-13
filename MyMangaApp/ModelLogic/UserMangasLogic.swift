//
//  UserMangasLogic.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/02/24.
//

import Foundation

@Observable
final class UserMangasLogic {
    var mangas: [UserMangaItem] = []
    
    func getMangasByGenre(genre: String) -> [UserMangaItem] {
        mangas.filter { $0.genres.contains { $0.genre == genre} }
    }
    
    func getGenres(mangas: [UserMangaItem]) -> [Genre] {
        var uniqueGenres = Set<Genre>()

        for manga in mangas {
            uniqueGenres.formUnion(manga.genres)
        }

        return Array(uniqueGenres)
    }
}
