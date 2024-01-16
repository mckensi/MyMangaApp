//
//  MangaByCategoryLogic.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/01/24.
//

import Foundation

@Observable
final class MangaByCategoryLogic {
    var mangas: [MangaItem] = []
    var page: Int = 0
}
