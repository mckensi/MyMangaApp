//
//  MangaMainView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import SwiftUI

struct MangaMainView: View {
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    var body: some View {
        switch deviceIdiom {
        case .pad:
            ContentViewIPad()
        case .vision:
            ContentViewIPhone()
        default:
            ContentViewIPhone()
        }
    }
}

#Preview {
    MangaMainView()
        .environment(MangaListVM.test)
        .environment(AccountVM.testLogin)
        .environment(MangaDetailVM.test)
        .environment(UserMangaCollectionVM.test)
}
