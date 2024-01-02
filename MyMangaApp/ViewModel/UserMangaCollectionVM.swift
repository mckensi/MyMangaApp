//
//  UserMangaCollectionVM.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 29/12/23.
//

import Foundation
import SwiftUI

@Observable
final class UserMangaCollectionVM {
    let network: DataInteractor
    let user: UserInteractor
    let mangasLogic = MangasLogic()
    
    var alertMsg: String = ""
    var showAlert: Bool = false
    
    init(network: DataInteractor = Network(), user: UserInteractor = User()) {
        self.network = network
        self.user = user
    }
    
    func getData() async {
        if !user.isUserLogged() {
            self.mangasLogic.mangas = []
            return
        }
        do {
            guard let token = try User.shared.getToken() else { throw UserError.errorGetToken }
            let mangasDownloaded = try await network.getUserCollection(token: token)
            await MainActor.run {
                self.mangasLogic.mangas = mangasDownloaded.sorted { $0.id < $1.id }
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

