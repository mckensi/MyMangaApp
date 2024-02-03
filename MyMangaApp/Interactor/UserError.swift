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
    case errorUpdatingToken
    case errorGetToken
    case errorGetEmail
    case errorSavePassword
    case errorGetPassword
    case errorDeletePassword
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
        case .errorSavePassword:
            "Error borrando el password"
        case .errorGetPassword:
            "Error borrando obteniendo el password"
        case .errorDeletePassword:
            "Error borrando el password"
        case .errorUpdatingToken:
            "Error actualizando el token"
        }
    }
}
