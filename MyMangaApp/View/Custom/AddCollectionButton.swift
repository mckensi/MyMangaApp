//
//  AddCollectionButton.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct AddCollectionButton: View {
    @Environment(MangaDetailVM.self) var vm
    let manga: MangaItem
    var body: some View {
        Button("Agregar", role: .none) {
            Task {
                await vm.addMangaToLibrary(manga: manga)
            }
        }
        .foregroundStyle(.background)
        .fontWeight(.bold)
        .frame(width: 300, height: 52)
        .background {
            RoundedRectangle(cornerRadius: 26)
        }
    }
}

#Preview {
    AddCollectionButton(manga: .test)
        .environment(MangaDetailVM.test)
}
