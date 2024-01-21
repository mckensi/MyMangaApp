//
//  MangasByAuthorLogic.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/01/24.
//
import SwiftUI

@Observable
final class MangasByAuthorLogic {
    var mangas: [MangaItem] = []
    var page: Int = 0
    var total: Int = 0
}

