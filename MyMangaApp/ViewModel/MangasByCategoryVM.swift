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
        
        Task {
            await getData()
            mangasLogic.mangas = mangasLogic.mangasWithoutFilters
        }

    }
    
    private func getData() async {
        do {
            let mangasDownloaded = try await network.getMangaListByGenre(page: mangasLogic.page, per: 20, genre: genre)
            let filteredArray = mangasDownloaded.0.filter { manga in
                !mangasLogic.mangasWithoutFilters.contains(manga)
            }

            await MainActor.run {
                self.mangasLogic.mangasWithoutFilters.append(contentsOf: filteredArray)
                mangasLogic.total = mangasDownloaded.1
                mangasLogic.page += 1
            }
            
        } catch {
            print(error)
            await MainActor.run {
                self.alertMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }

    func getNextPage(idManga: Int) {
        guard idManga == mangasLogic.mangasWithoutFilters.last?.id else { return }
        if mangasLogic.mangasWithoutFilters.count < mangasLogic.total {
            Task {
                await getData()
            }
        }
    }    
}

