//
//  MyMangaAppApp.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import SwiftUI

@main
struct MyMangaAppApp: App {
    @State var mangaListVM = MangaListVM()
    @State var accountVM = AccountVM()
    @State var mangaDetailVM = MangaDetailVM()
    @State var userMangaCollectionVM = UserMangaCollectionVM()
    
    var body: some Scene {
        WindowGroup {
            MangaMainView()
                .environment(mangaListVM)
                .environment(accountVM)
                .environment(mangaDetailVM)
                .environment(userMangaCollectionVM)
        }
    }
}
