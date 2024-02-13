//
//  MangaDetailVM.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import Foundation

@Observable
final class MangaDetailVM {
    let manga: MangaItem
    let network: DataInteractor
    var alertMsg: String = ""
    var showAlert: Bool = false
    
    var showSuccessAddedMangaAlert: Bool = false
    var authorBooks: [MangaItem] = []
    var authorsAndBooks: [MangaAuthor] = []

    init(network: DataInteractor = Network(), manga: MangaItem) {
        self.network = network
        self.manga = manga
        getBooksAllAuthors(authors: manga.authors)
    }
    
    func addMangaToLibrary(volumesOwned: [Int], readingVolume: Int) async {
        let mangaRequest = UserMangaCollectionRequest(
            manga: manga.id,
            completeCollection: false,
            volumesOwned: volumesOwned,
            readingVolume: readingVolume
        )
        
        do {
            guard let token = try User.shared.getToken() else { throw UserError.errorGetToken }
            try await network.postCollectionManga(token: token, manga: mangaRequest)
            await MainActor.run {
                self.showSuccessAddedMangaAlert.toggle()
            }
        } catch {
            print(error)
            await MainActor.run {
                self.alertMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func getBooksByAuthor(id: String) {
        Task {
            do {
                let mangas = try await network.getMangasByAuthor(id: id, page: 0, per: 10)
                await MainActor.run {
                    self.authorBooks = mangas.0
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
    
    private func getBooksAllAuthors(authors: [Author]) {
        Task {
            let mangas = await withTaskGroup(of: MangaAuthor?.self, returning: [MangaAuthor].self) { group in
                var result: [MangaAuthor] = []
                for author in authors {
                    group.addTask {
                        do {
                            let mangas = try await self.network.getMangasByAuthor(id: author.id, page: 0, per: 10).0
                            let mangasAndAuthor = MangaAuthor(author: author, mangas: mangas)
                            return mangasAndAuthor
                        } catch {
                            print(error)
                            return nil
                        }
                    }
                }
                
                for await mangasByAuthor in group.compactMap({ $0 }) {
                    result.append(mangasByAuthor)
                }
                
                return result
            }
            await MainActor.run {
                authorsAndBooks = mangas
            }
        }
    }
    
}
