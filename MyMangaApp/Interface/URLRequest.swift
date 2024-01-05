//
//  URLRequest.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import Foundation

extension URLRequest {
    static func get(url: URL, appToken: String? = nil, token: String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(appToken, forHTTPHeaderField: "App-Token")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    static func delete(url: URL, appToken: String? = nil, token: String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(appToken, forHTTPHeaderField: "App-Token")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    static func post<JSON>(url: URL, data: JSON, method: String = "POST", appToken: String? = nil, credentials: String? = nil, token: String? = nil) -> URLRequest where JSON: Codable {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = method
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(appToken, forHTTPHeaderField: "App-Token")
        if let credentials = credentials {
            request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        }
        if let credentials = credentials {
            request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        }
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.httpBody = try? JSONEncoder().encode(data)
     
        return request
    }
    
    static func post(url: URL, method: String = "POST", appToken: String? = nil, credentials: String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = method
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(appToken, forHTTPHeaderField: "App-Token")
        if let credentials = credentials {
            request.setValue(credentials, forHTTPHeaderField: "Authorization")
        }
     
        return request
    }
}

