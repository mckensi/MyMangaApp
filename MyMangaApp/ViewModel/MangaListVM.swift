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
            let mangasDownloaded = try await network.getMangaList(page: 0, per: 20)
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
