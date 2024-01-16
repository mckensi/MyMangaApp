//
//  MangasByCategoryVM.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 13/01/24.
//

import Foundation
import SwiftUI

@Observable
final class MangasByCategoryVM {
    let network: DataInteractor
    let mangasLogic = MangaByCategoryLogic()
    
    var alertMsg: String = ""
    var showAlert: Bool = false
    
    var genre: String
    
    init(network: DataInteractor = Network(), genre: String) {
        self.network = network
        self.genre = genre
        
        Task { await getData(genre: genre) }
    }
    
    private func getData(genre: String) async {
        do {
            let mangasDownloaded = try await network.getMangaListByGenre(page: mangasLogic.page, per: 20, genre: genre)
            await MainActor.run {
                self.mangasLogic.mangas.append(contentsOf: mangasDownloaded)
                self.mangasLogic.page += 10
            }
            
        } catch {
            print(error)
            await MainActor.run {
                self.alertMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
}

