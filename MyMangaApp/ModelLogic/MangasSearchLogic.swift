//
//  MangasSearchLogic.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/01/24.
//

import Foundation


@Observable
final class MangasSearchLogic {
    var mangas: [MangaItem] = []
    var authors: [Author] = []

    var pageMangas: Int = 1
    var totalMangas: Int = 0
}
