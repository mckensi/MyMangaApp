//
//  ErrorResponseDto.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 7/01/24.
//

import Foundation

struct ErrorResponseDto: Codable {
    let reason: String
    let error: String
}
