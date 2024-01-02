//
//  MangaDetailVM.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import Foundation

@Observable
final class MangaDetailVM {
    let network: DataInteractor
    
    var alertMsg: String = ""
    var showAlert: Bool = false
    
    var showSuccessAddedMangaAlert: Bool = false
    init(network: DataInteractor = Network()) {
        self.network = network
    }
    
    func addMangaToLibrary(manga: MangaItem) async {
        let mangaRequest = UserMangaCollectionRequest(
            manga: manga.id,
            completeCollection: false,
            volumesOwned: [1, 2, 3],
            readingVolume: 1
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
}
