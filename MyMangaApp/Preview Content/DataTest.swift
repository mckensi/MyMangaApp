//
//  DataTest.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/12/23.
//

import Foundation

struct DataTest: DataInteractor {
    func searchMangaContains(searchText: String, page: Int, per: Int) async throws -> ([MangaItem], Int) {
        let url = Bundle.main.url(forResource: "searchMangaContains", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode(MangaListDto.self, from: data)
        return (listRes.items.map { $0.toPresentation }, listRes.metadata.total)
    }
    
    func searchAuthor(text: String) async throws -> [Author] {
        let url = Bundle.main.url(forResource: "searchAuthor", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode([AuthorDto].self, from: data)
        return listRes.map { $0.toPresentation }
    }
    
    
    func getMangasByAuthor(id: String, page: Int, per: Int) async throws -> ([MangaItem], Int) {
        let url = Bundle.main.url(forResource: "listMangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode(MangaListDto.self, from: data)
        return (listRes.items.map { $0.toPresentation }, listRes.metadata.total)
    }
    
    func deleteUserManga(id: Int) async throws {
        print("Manga deleted")
    }
    

    func getMangaDictionaryByGenre(page: Int, per: Int, genres: [String]) async throws -> [MangaItem] {
        let url = Bundle.main.url(forResource: "listMangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode(MangaListDto.self, from: data)
        return listRes.items.map { $0.toPresentation }
    }
    
    func getMangeGenres() async throws -> [String] {
        return ["Action", "Adventure"]
    }
    
    func getMangaListByGenre(page: Int, per: Int, genre: String) async throws -> ([MangaItem], Int) {
        let url = Bundle.main.url(forResource: "listMangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode(MangaListDto.self, from: data)
        return (listRes.items.map { $0.toPresentation }, listRes.metadata.total)
    }
    
    func postCollectionManga(token: String, manga: UserMangaCollectionRequest) async throws {
        print("collection agregada")
    }
    
    func login(email: String, password: String) async throws -> String {
        return "1234token"
    }
    
    func createUser(email: String, password: String) async throws {}
    
    func getMangaList(page: Int, per: Int) async throws -> [MangaItem] {
        let url = Bundle.main.url(forResource: "listMangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode(MangaListDto.self, from: data)
        return listRes.items.map { $0.toPresentation }
    }
    
    func getUserCollection() async throws -> [UserMangaItem] {
        let url = Bundle.main.url(forResource: "userCollectionTest", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let listRes = try JSONDecoder().decode([UserCollectionListDto].self, from: data)
        var mangas: [UserMangaItem] = []
        
        listRes.forEach { collection in
            mangas.append(collection.manga.toPresentationUserManga)
        }
        
        return mangas
    }
    
    func getUserManga(id: Int) async throws -> UserCollectionManga {
        let url = Bundle.main.url(forResource: "userManga", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let mangaDto = try JSONDecoder().decode(UserCollectionMangaDto.self, from: data)
        return mangaDto.toPresentation
    }
    
}

struct UserDataTestLogin: UserInteractor {
    func getEmail() throws -> String {
        "daniel@gmail.com"
    }
    
    func getCredentials() -> String? {
        "Hola 1234"
    }
    
    func saveToken(token: String, account: String) throws {
        print("1234")
    }
    
    func getToken() throws -> String? {
        "1234"
    }
    
    func closeSession() throws {
        print("close test session")
    }
    
    func isUserLogged() -> Bool {
        true
    }
}


struct UserDataTestAnonimous: UserInteractor {
    func getEmail() throws -> String {
        ""
    }
    
    func getCredentials() -> String? {
        ""
    }
    
    func saveToken(token: String, account: String) throws {
        print("")
    }
    
    func getToken() throws -> String? {
        ""
    }
    
    func closeSession() throws {
        print("close test session")
    }
    
    func isUserLogged() -> Bool {
        false
    }
    
}

