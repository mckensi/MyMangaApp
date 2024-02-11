//
//  WithoutResultsView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 11/02/24.
//

import SwiftUI

struct WithoutResultsView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Sin resultados")
                .font(.title2)
                .fontWeight(.bold)
            Text("Intenta una nueva busqueda.")
                .foregroundStyle(.secondary)
            Spacer()
        }
     
    }
}

#Preview {
    WithoutResultsView()
}
