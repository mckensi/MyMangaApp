//
//  MangasLogic.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/12/23.
//

import Foundation

@Observable
final class MangasLogic {
    var mangas: [MangaItem] = []
    
    func getMangasByGenre(genre: String) -> [MangaItem] {
        mangas.filter { $0.genres.contains { $0.genre == genre} }
    }
    
    func getGenres(mangas: [MangaItem]) -> [Genre] {
        var uniqueGenres = Set<Genre>()

        for manga in mangas {
            uniqueGenres.formUnion(manga.genres)
        }

        return Array(uniqueGenres)
    }

}
