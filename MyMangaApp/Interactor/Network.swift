//
//  Network.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import SwiftUI

protocol DataInteractor {
    func getMangeGenres() async throws -> [String]
    func getMangaList(page: Int, per: Int) async throws -> [MangaItem]
    func createUser(email: String, password: String) async throws
    func login(email: String, password: String) async throws -> String
    func postCollectionManga(token: String, manga: UserMangaCollectionRequest) async throws
    func getUserCollection()  async throws -> [MangaItem]
    func getMangaListByGenre(page: Int, per: Int, genre: String) async throws -> ([MangaItem], Int)
    func getMangaDictionaryByGenre(page: Int, per: Int, genres: [String]) async throws -> [MangaItem]
    func getUserManga(id: Int) async throws -> UserCollectionManga
    func deleteUserManga(id: Int) async throws
    func getMangasByAuthor(id: String, page: Int, per: Int) async throws -> ([MangaItem], Int)
    func searchMangaContains(searchText: String, page: Int, per: Int) async throws -> ([MangaItem], Int)
    func searchAuthor(text: String) async throws -> [Author]
}

public struct Network: DataInteractor {
    
    static let shared = Network()
    
    let AK:[UInt8] = [0x3A+0x39,0x70-0x24,0x76-0x2F,0x4D-0x05,0x1F+0x14,0x35+0x03,0x8D-0x3F,0xC3-0x5B,0x20+0x25,0x21+0x29,0x05+0x2B,0xA2-0x43,0x24+0x3D,0x0A+0x64,0x17+0x55,0x72-0x29,0x1A+0x3D,0x83-0x0C,0x50+0x18,0x90-0x1D,0xE0-0x66,0x55-0x24,0x40-0x13,0x44+0x08,0x8E-0x2D,0x4A+0x28,0x72-0x2F,0xA7-0x3B,0x43+0x02,0x4A+0x25,0x9A-0x32,0x5E+0x0B,0x16+0x2B,0x11+0x37,0x3E+0x13,0x3B+0x36,0x12+0x4F,0xDE-0x65,0x8A-0x44,0x01+0x2F,0x7A-0x34,0x0A+0x4F]
    
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else if response.statusCode == 401 {
            let errorResponse = try JSONDecoder().decode(ErrorResponseDto.self, from: data)
            if errorResponse.reason == "Users not authenticated." {
                guard let email = try User.shared.getEmail() else {
                    throw NetworkError.unknown
                }
                guard let password = try User.shared.getPassword() else {
                    throw NetworkError.unknown
                }
                
                let token = try await login(email: email, password: password)
                try User.shared.updateToken(token: token, account: email)
                var retryRequest = request
                retryRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                return try await getJSON(request: retryRequest, type: type)
            } else {
                throw NetworkError.status(response.statusCode)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func get(request: URLRequest) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != 200 {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func post(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        
        if response.statusCode == 401 {
            let token = try await renewUser()
            let account = try User.shared.getEmail() ?? ""
            try User.shared.saveToken(token: token, account: account)
            var retryRequest = request
            retryRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let (_, response) = try await URLSession.shared.getData(for: retryRequest)
        } else if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func postString(request: URLRequest, status: Int = 200) async throws -> String {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
        
        if let stringValue = String(data: data, encoding: .utf8) {
               return stringValue
           } else {
               throw NetworkError.unknown
           }
    }
    
    func postJSON<JSON>(request: URLRequest, type: JSON.Type, status: Int = 200) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == status {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else if response.statusCode == 401 {
            let token = try await renewUser()
            let account = try User.shared.getEmail() ?? ""
            try User.shared.saveToken(token: token, account: account)
            var retryRequest = request
            retryRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            return try await postJSON(request: retryRequest, type: type, status: status)
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func getMangeGenres() async throws -> [String] {
        try await getJSON(request: .get(url: .getMangasGenres()), type: [String].self)
    }

    func getMangaList(page: Int, per: Int) async throws -> [MangaItem] {
        let mangaList = try await getJSON(request: .get(url: .getMangaList(page: page, per: per)), type: MangaListDto.self)
        
        var result: [MangaItem] = []
        for manga in mangaList.items {
            result.append(manga.toPresentation)
        }
        return result
    }
    
    func getMangaListByGenre(page: Int, per: Int, genre: String) async throws -> ([MangaItem], Int) {
        
        let mangaListByGenre = try await getJSON(request: .get(url: .getMangaListByGenre(page: page, per: per, genre: genre)), type: MangaListDto.self)
        
        var result: [MangaItem] = []
        for manga in mangaListByGenre.items {
            result.append(manga.toPresentation)
        }
        
        return (result, mangaListByGenre.metadata.total)
    }
    
    
    func getMangaDictionaryByGenre(page: Int, per: Int, genres: [String]) async throws -> [MangaItem] {
        return await withTaskGroup(of: [MangaItem]?.self, returning: [MangaItem].self) { group in
            var result: [MangaItem] = []
            for genre in genres {
                group.addTask {
                    do {
                        let mangas = try await getMangaListByGenre(page: page, per: per, genre: genre).0
                        return mangas
                    } catch {
                        print(error)
                        return nil
                    }
                }
            }
            
            for await mangasByGenre in group.compactMap({ $0 }) {
                result.append(contentsOf: mangasByGenre)
            }
            
            return result
        }
    }
    
    func createUser(email: String, password: String)  async throws {
        try await post(request: .post(url: .postCreateUser(), data: CreateUser(email: email, password: password), appToken: String(data: Data(AK), encoding: .utf8)!), status: 201)
    }

    
    func login(email: String, password: String) async throws -> String {
        let credentials = "\(email):\(password)"
        if let encodedCredentials = credentials.data(using: .utf8) {
            let auth = "Basic \(encodedCredentials.base64EncodedString())"
            return try await postString(request: .post(url: .postLogin(), appToken: String(data: Data(AK), encoding: .utf8), credentials: auth), status: 200)
        } else {
            throw NetworkError.unknown
        }
    }
    
    func renewUser() async throws -> String {
        guard let token = try User.shared.getToken() else { throw UserError.errorGetToken }
        return try await postString(request: .post(url: .postRenew(), appToken: String(data: Data(AK), encoding: .utf8), token: token), status: 200)
    }
    
    func postCollectionManga(token: String, manga: UserMangaCollectionRequest) async throws {
        try await post(request: .post(url: .postCollectionManga(), data: manga, appToken: String(data: Data(AK), encoding: .utf8), token: token), status: 201)
    }
    
    func getUserCollection() async throws -> [MangaItem] {
        guard let token = try User.shared.getToken() else { throw UserError.errorGetToken }
        let userMangaCollection = try await getJSON(request: .get(url: .getUserMangaCollection(), appToken: String(data: Data(AK), encoding: .utf8), token: token), type: [UserCollectionListDto].self)
        
        var result: [MangaItem] = []
        for collection in userMangaCollection {
            result.append(collection.manga.toPresentation)
        }
        return result
    }
    
    func getUserManga(id: Int) async throws -> UserCollectionManga {
        guard let token = try User.shared.getToken() else { throw UserError.errorGetToken }
        let userManga = try await getJSON(request: .get(url: .getUserManga(id: id), appToken: String(data: Data(AK), encoding: .utf8), token: token), type: UserCollectionMangaDto.self)
        
        return userManga.toPresentation
    }
    
    func deleteUserManga(id: Int) async throws {
        guard let token = try User.shared.getToken() else { throw UserError.errorGetToken }
        try await get(request: .delete(url: .deleteUserManga(id: id), appToken: String(data: Data(AK), encoding: .utf8), token: token))
    }
    
    func getMangasByAuthor(id: String, page: Int, per: Int) async throws -> ([MangaItem], Int){
        let mangaList = try await getJSON(request: .get(url: .getMangasByAuthorId(id: id, page: page, per: per)), type: MangaListDto.self)
        var mangaItems: [MangaItem] = []
        for item in mangaList.items {
            mangaItems.append(item.toPresentation)
        }
        return (mangaItems, mangaList.metadata.total)
    }
    
    func searchMangaContains(searchText: String, page: Int, per: Int) async throws -> ([MangaItem], Int) {
        let mangaList = try await getJSON(request: .get(url: .searchMangaContains(search: searchText, page: page, per: per)), type: MangaListDto.self)
        var mangas:[MangaItem] = []
        
        mangaList.items.forEach { manga in
            mangas.append(manga.toPresentation)
        }
        
        return (mangas, mangaList.metadata.total)
    }

    func searchAuthor(text: String) async throws -> [Author] {
        let authorList = try await getJSON(request: .get(url: .searchAuthor(search: text)), type: [AuthorDto].self)
        var authors:[Author] = []
        
        authorList.forEach { author in
            authors.append(author.toPresentation)
        }
        
        return authors
    }
    
}
