//
//  MangaListView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import Foundation
import SwiftUI

@Observable
final class MangaListVM {
    let network: DataInteractor
    let mangasLogic = MangasLogic()
    
    var alertMsg: String = ""
    var showAlert: Bool = false
    
    init(network: DataInteractor = Network()) {
        self.network = network
        
        Task { await getData() }
    }
    
    private func getData() async {
        do {
            let genres = try await network.getMangeGenres()
  
            let mangasDownloaded = try await network.getMangaDictionaryByGenre(page: 0, per: 10, genres: genres)
            await MainActor.run {
                self.mangasLogic.mangas = mangasDownloaded
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
