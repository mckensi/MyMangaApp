//
//  AddButtonView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct AddButtonView: View {
    @Binding var showSelectVolumesView: Bool
    @Binding var showAccountView: Bool
    let manga: MangaItem
    let vm: MangaDetailVM
    @Environment(AccountVM.self) var accountVm

    var body: some View {
        Button {
            if accountVm.isUserLogged {
                if manga.volumes != nil {
                    showSelectVolumesView.toggle()
                } else {
                    Task {
                        await vm.addMangaToLibrary(volumesOwned: [1], readingVolume: 1)
                    }
                }
            } else {
                showAccountView.toggle()
            }
        } label: {
            AddCollectionButton()
        }
        .buttonStyle(.plain)
        .hoverEffect()
    }
}


#Preview {
    AddButtonView(
        showSelectVolumesView: .constant(false),
        showAccountView: .constant(false),
        manga: .test,
        vm: MangaDetailVM.test
    )
    .environment(AccountVM.testLogin)
}
