//
//  MangasVolumeSelectionVM.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 27/01/24.
//

import Foundation

@Observable
final class MangasVolumeSelectionVM {
    let mangasLogic =  MangasVolumeSelectionLogic()
    
    var alertMsg: String = ""
    var showAlert: Bool = false
    
    func addVolume(volume: Int) {
        if mangasLogic.mangasSelected.contains(volume) {
            mangasLogic.mangasSelected.removeAll { volumeOnArray in
                volumeOnArray == volume
            }
        } else {
            mangasLogic.mangasSelected.append(volume)
        }
    }
    
    func selectReadingVolume(volume: Int) {
        mangasLogic.mangaReading = volume
    }
    
    func isEnabledButton() -> Bool {
        return !mangasLogic.mangasSelected.isEmpty && mangasLogic.mangaReading != nil
    }
    
    func selectAllVolumes(volumes: Int) {
        for index in 1...volumes {
            addVolume(volume: index)
        }
    }
}
