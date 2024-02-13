//
//  UserMangaDetailVM.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 4/01/24.
//

import Foundation

@Observable
final class UserMangaDetailVM {
    
    let id: Int
    let network: DataInteractor
    var alertMsg: String = ""
    var showAlert: Bool = false
    var showSuccessAddedMangaAlert: Bool = false
    var userManga: UserCollectionManga?
    var authorsAndBooks: [MangaAuthor] = []

    init(id: Int, network: DataInteractor = Network()) {
        self.id = id
        self.network = network

        Task {
            await getManga(id: id)
        }
    }
    
    func getManga(id: Int) async {
        do {
            let manga = try await network.getUserManga(id: id)
            self.userManga = manga
        } catch {
            await MainActor.run {
                alertMsg = error.localizedDescription
                showAlert.toggle()
            }
        }
    }
    
    func removeUserManga(success: @escaping () -> Void) {
        Task {
            do {
                try await network.deleteUserManga(id: id)
                await MainActor.run {
                    success()
                }
            } catch {
                await MainActor.run {
                    alertMsg = error.localizedDescription
                    showAlert.toggle()
                }
            }
        }
    }
    
    func getBooksAllAuthors(authors: [Author]) {
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

