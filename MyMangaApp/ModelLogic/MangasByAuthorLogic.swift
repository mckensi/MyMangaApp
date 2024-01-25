//
//  MangasByAuthorLogic.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/01/24.
//
import SwiftUI

@Observable
final class MangasByAuthorLogic {
    var mangas: [MangaItem] = []
    var mangasWithoutFilters: [MangaItem] = []
    var themeFilter: Theme? = nil
    var demographicFilter: Demographic? = nil
    var orderedByTitle: Bool = false

    var page: Int = 1
    var total: Int = 0
    
    func getAllThemes() -> [Theme] {
        var themes: Set<Theme> = []
        mangasWithoutFilters.forEach { manga in
            manga.themes.forEach { theme in
                themes.insert(theme)
            }
        }
        return Array(themes).sorted { $0.theme < $1.theme }
    }
    
    func getAllDemographics() -> [Demographic] {
        var demographics: Set<Demographic> = []
        mangasWithoutFilters.forEach { manga in
            manga.demographics.forEach { demographic in
                demographics.insert(demographic)
            }
        }
        return Array(demographics).sorted { $0.demographic < $1.demographic }
    }
    
    func applyFilterByTheme(theme: Theme) {
        demographicFilter = nil
        if themeFilter == theme {
            mangas = mangasWithoutFilters
            themeFilter = nil
        } else {
            themeFilter = theme
            mangas = mangasWithoutFilters.filter { manga in
                manga.themes.contains(theme)
            }
        }
    }
    
    func applyFilterByDemographic(demographic: Demographic) {
        themeFilter = nil
        if demographicFilter == demographic {
            mangas = mangasWithoutFilters
            demographicFilter = nil
        } else {
            demographicFilter = demographic
            mangas = mangasWithoutFilters.filter { manga in
                manga.demographics.contains(demographic)
            }
        }
    }
    
    func orderByTitle() {
        themeFilter = nil
        demographicFilter = nil
        
        if orderedByTitle {
            mangas = mangasWithoutFilters
        } else {
            mangas = mangasWithoutFilters.sorted { $0.title < $1.title }
        }

        orderedByTitle.toggle()
    }

}

