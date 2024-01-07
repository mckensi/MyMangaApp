//
//  User.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 21/12/23.
//

import Foundation
import Security

protocol UserInteractor {
    func getCredentials() -> String?
    func saveToken(token: String, account: String) throws
    func getToken() throws -> String?
    func closeSession() throws
    func isUserLogged() -> Bool
    func getEmail() throws -> String
}

public struct User: UserInteractor {

    static let shared = User()

    let service = "MyMangaApp"
    var email: String? = nil
    var password: String? = nil

    func getCredentials() -> String? {
        let credentials = "\(email ?? ""):\(password ?? "")"
        
        if let encodedCredentials = credentials.data(using: .utf8) {
            return "Basic \(encodedCredentials.base64EncodedString())"
        }

        return nil
    }
    
    func saveEmail(email: String) throws {
        if let data = email.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: "email",
                kSecValueData as String: data
            ]

            SecItemDelete(query as CFDictionary)

            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw UserError.errorSaveToken
            }
        }
    }
    
    
    func deleteEmail() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: "email"
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            throw UserError.errorDeleteEmail
        }
    }
    
    func getEmail() throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: "email",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        } else {
            throw UserError.errorGetEmail
        }
    }

    func saveToken(token: String, account: String) throws {
        if let data = token.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecValueData as String: data
            ]

            SecItemDelete(query as CFDictionary)

            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw UserError.errorSaveToken
            }
        }
    }

    func getToken() throws -> String? {
        guard let account = try getEmail() else { return nil }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        } else {
            throw UserError.errorGetToken
        }
    }

    func deleteToken(account: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            throw UserError.errorDeleteToken
        }
    }

    func closeSession() throws {
        guard let email = try getEmail() else { throw UserError.errorGetEmail }
        
        try deleteToken(account: email)
        try deleteEmail()
    }
    
    func isUserLogged() -> Bool {
        do {
            if try User.shared.getToken() != nil {
                return true
            } else {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
   
    }
    
    func getEmail() throws -> String {
        try User.shared.getEmail() ?? ""
    }
}
