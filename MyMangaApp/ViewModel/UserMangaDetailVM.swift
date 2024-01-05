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
            alertMsg = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    func removeUserManga() {
        
    }
}

