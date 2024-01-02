//
//  URL.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import Foundation

let prod = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/")!
#if DEBUG
let dev = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/")!
#endif

#if RELEASE
let api = prod
#else
let api = dev // Aquí iría DESA si hubiera un DESA o lo que toque
#endif


extension URL {
    static func getMangaList(page: Int = 0, per: Int = 20) -> URL {
        api.appending(path: "list/mangas")
            .appending(
                queryItems: [
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "per", value: "\(per)")
                ]
            )
    }
    
    static func postCreateUser() -> URL {
        api.appending(path: "users")
    }
    
    static func postLogin() -> URL {
        api.appending(path: "users/login")
    }
    
    static func postCollectionManga() -> URL {
        api.appending(path: "collection/manga")
    }
    
    static func getUserMangaCollection() -> URL {
        api.appending(path: "collection/manga")
    }
}

