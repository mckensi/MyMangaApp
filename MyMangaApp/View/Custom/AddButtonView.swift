//
//  AddButtonView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct AddButtonView: View {
    @Binding var showAccountView: Bool
    let manga: MangaItem
    let vm: MangaDetailVM

    var body: some View {
        Button {
            if manga.volumes != nil {
                showAccountView.toggle()
            } else {
                Task {
                    await vm.addMangaToLibrary(manga: manga, volumesOwned: [1], readingVolume: 1)
                }
            }
        } label: {
            AddCollectionButton()
        }
        .buttonStyle(.plain)
        .hoverEffect()
    }
}


#Preview {
    AddButtonView(showAccountView: .constant(false), manga: .test, vm: MangaDetailVM.test)
}
