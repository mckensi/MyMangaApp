//
//  MangasSearchVM.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/01/24.
//

import SwiftUI

@Observable
final class MangasSearchVM {
    let network: DataInteractor
    let mangasLogic = MangasSearchLogic()
    
    var alertMsg: String = ""
    var showAlert: Bool = false
    var showWithoutResults: Bool = false
    private var textToSeach: String = ""
    
    init(network: DataInteractor = Network()) {
        self.network = network
    }
    
    func searchMangas(text: String, removeAll: Bool) {
        textToSeach = text
       
        if removeAll {
            Task {
                await MainActor.run {
                    mangasLogic.mangas.removeAll()
                    mangasLogic.totalMangas = 0
                    mangasLogic.pageMangas = 1
                    showWithoutResults = false
                }
            }
        }

        Task {
            do {
                let mangas = try await network.searchMangaContains(searchText: text, page: mangasLogic.pageMangas, per: 20)
                let filteredArray = mangas.0.filter { manga in
                    !mangasLogic.mangas.contains(manga)
                }.sorted { $0.id < $1.id }
                mangasLogic.mangas.append(contentsOf: filteredArray)
                mangasLogic.totalMangas = mangas.1
                mangasLogic.pageMangas += 1
                showWithoutResults = filteredArray.isEmpty
            } catch {
                await MainActor.run {
                    alertMsg = error.localizedDescription
                    showAlert.toggle()
                }
            }
        }
    }
    
    func searchMangaNextPage(idManga: Int) {
        guard idManga == mangasLogic.mangas.last?.id else { return }
        if mangasLogic.mangas.count < mangasLogic.totalMangas {
            Task {
                await MainActor.run {
                    searchMangas(text: textToSeach, removeAll: false)
                }
            }
        }
    }
    
    func searchAuthors(text: String) {
        mangasLogic.authors.removeAll()
        showWithoutResults = false
        Task {
            do {
                let authors = try await network.searchAuthor(text: text)
                mangasLogic.authors.append(contentsOf: authors)
                showWithoutResults = authors.isEmpty
            } catch {
                await MainActor.run {
                    alertMsg = error.localizedDescription
                    showAlert.toggle()
                }
            }
        }
    }
    
    func clearSearch() {
        Task {
            await MainActor.run {
                mangasLogic.mangas.removeAll()
                mangasLogic.pageMangas = 1
                mangasLogic.totalMangas = 0
                mangasLogic.authors.removeAll()
            }
        }
    }
}
