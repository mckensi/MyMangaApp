//
//  AddCollectionButton.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 26/01/24.
//

import SwiftUI

struct AddCollectionButton: View {
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        switch deviceIdiom {
        case .pad:
            Text("Agregar")
             .fontWeight(.bold)
             .foregroundStyle(.background)
             .frame(width: 200, height: 52)
             .background {
                 RoundedRectangle(cornerRadius: 12)
             }
        case .vision:
            Text("Agregar")
             .fontWeight(.bold)
             .frame(width: 200, height: 52)
        default:
            Text("Agregar")
             .fontWeight(.bold)
             .foregroundStyle(.background)
             .frame(width: 300, height: 52)
             .background {
                 RoundedRectangle(cornerRadius: 26)
             }
        }
    }
}

#Preview {
    AddCollectionButton()
}
