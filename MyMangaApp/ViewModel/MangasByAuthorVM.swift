//
//  MangasByAuthorVM.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/01/24.
//

import Foundation

import Foundation
import SwiftUI

@Observable
final class MangasByAuthorVM {
    let network: DataInteractor
    let mangasLogic = MangasByAuthorLogic()
    
    var alertMsg: String = ""
    var showAlert: Bool = false
    
    var author: Author

    init(network: DataInteractor = Network(), author: Author) {
        self.network = network
        self.author = author
        
        Task { await getData() }
    }
    
    private func getData() async {
        do {
            let mangasDownloaded = try await network.getMangasByAuthor(id: author.id, page: mangasLogic.page, per: 20)
            let filteredArray = mangasDownloaded.0.filter { manga in
                !mangasLogic.mangas.contains(manga)
            }

            await MainActor.run {
                mangasLogic.mangas.append(contentsOf: filteredArray)
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
        guard idManga == mangasLogic.mangas.last?.id else { return }
        if mangasLogic.mangas.count < mangasLogic.total {
            Task {
                await getData()
            }
        }
    }
}
