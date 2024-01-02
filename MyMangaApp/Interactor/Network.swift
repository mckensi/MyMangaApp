//
//  Network.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import SwiftUI

protocol DataInteractor {
    func getMangaList(page: Int, per: Int) async throws -> [MangaItem]
    func createUser(email: String, password: String) async throws
    func login(email: String, password: String) async throws -> String
    func postCollectionManga(token: String, manga: UserMangaCollectionRequest) async throws
    func getUserCollection(token: String)  async throws -> [MangaItem]
}

public struct Network: DataInteractor {
    
    static let shared = Network()
    
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func post(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != status {
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
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }

    func getMangaList(page: Int, per: Int) async throws -> [MangaItem] {
        let mangaList = try await getJSON(request: .get(url: .getMangaList(page: page, per: per)), type: MangaListDto.self)
        
        var result: [MangaItem] = []
        for manga in mangaList.items {
            result.append(manga.toPresentation)
        }
        return result
    }
    
    
    func createUser(email: String, password: String)  async throws {
        try await post(request: .post(url: .postCreateUser(), data: CreateUser(email: email, password: password), appToken: "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY"), status: 201)
    }

    
    func login(email: String, password: String) async throws -> String {
        let credentials = "\(email):\(password)"
        if let encodedCredentials = credentials.data(using: .utf8) {
            let auth = "Basic \(encodedCredentials.base64EncodedString())"
            return try await postString(request: .post(url: .postLogin(), appToken: "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY", credentials: auth), status: 200)
        } else {
            throw NetworkError.unknown
        }
    }
    
    func postCollectionManga(token: String, manga: UserMangaCollectionRequest) async throws {
        try await post(request: .post(url: .postCollectionManga(), data: manga, appToken: "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY", token: token), status: 201)
    }
    
    func getUserCollection(token: String)  async throws -> [MangaItem] {
        let userMangaCollection = try await getJSON(request: .get(url: .getUserMangaCollection(), appToken: "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY", token: token), type: [UserCollectionListDto].self)
        
        var result: [MangaItem] = []
        for collection in userMangaCollection {
            result.append(collection.manga.toPresentation)
        }
        return result
    }
    
}
