//
//  DataTest.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/12/23.
//

import Foundation

struct DataTest: DataInteractor {
    func getUserCollection(token: String) async throws -> [MangaItem] {
        let url = Bundle.main.url(forResource: "userCollectionTest", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode(MangaListDto.self, from: data)
        return listRes.items.map { $0.toPresentation }
    }
    
    func postCollectionManga(token: String, manga: UserMangaCollectionRequest) async throws {
        
    }
    
    func login(email: String, password: String) async throws -> String {
        return ""
    }
    
    func createUser(email: String, password: String) async throws {}
    
    func getMangaList(page: Int, per: Int) async throws -> [MangaItem] {
        let url = Bundle.main.url(forResource: "listMangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode(MangaListDto.self, from: data)
        return listRes.items.map { $0.toPresentation }
    }
}
