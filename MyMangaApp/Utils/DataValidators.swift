//
//  DataValidators.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 26/12/23.
//

import Foundation

struct Validators {
    static let shared = Validators()
    
    func noValidate(_ value: String) -> String? {
        nil
    }
    
    func isEmpty(_ value: String) -> String? {
        value.isEmpty ? "no puede estar vacio." : nil
    }
    
    func validEmail(_ value: String) -> String? {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        do {
            let regex = try Regex(emailRegex)
            if let _ = try regex.wholeMatch(in: value) {
                return nil
            } else {
                return "no es un email válido."
            }
        } catch {
            return "no es un email válido."
        }
    }
    
    func greaterThan4(_ value: String) -> String? {
        var msg = ""
        if let err = isEmpty(value) {
            msg += err
        }
        if value.count < 4 {
            if msg.isEmpty {
                msg = "El campo debe tener mas de 4 caracteres."
            } else {
                msg = "\(msg.dropLast()) y debe tener mas de 4 caracteres."
            }
        }
        if msg.isEmpty {
            return nil
        } else {
            return msg
        }
    }
}
