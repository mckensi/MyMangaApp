//
//  UserError.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 21/12/23.
//

import Foundation

public enum UserError: Error, CustomStringConvertible {
    case errorDeleteToken
    case errorDeleteEmail
    case errorSaveToken
    case errorGetToken
    case errorGetEmail
    case unknown
    
    public var description: String {
        switch self {
        case .errorDeleteToken:
            "Error borrando el token"
        case .errorSaveToken:
            "Error guardando el token"
        case .errorGetToken:
            "Error recuperando el token"
        case .unknown:
            "Error desconocido"
        case .errorGetEmail:
            "Error obteniendo el email"
        case .errorDeleteEmail:
            "Error borrando el email"
        }
    }
}
