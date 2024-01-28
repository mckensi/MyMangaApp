//
//  AddCollectionButton.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct AddCollectionButton: View {
    var body: some View {
       Text("Agregar")
        .foregroundStyle(.background)
        .fontWeight(.bold)
        .frame(width: 300, height: 52)
        .background {
            RoundedRectangle(cornerRadius: 26)
        }
    }
}

#Preview {
    AddCollectionButton()
}
