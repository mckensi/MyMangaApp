//
//  CategoryTitleView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 3/02/24.
//

import SwiftUI

struct CategoryTitleView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .bold()
            Image(systemName: "chevron.right")
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}

#Preview {
    CategoryTitleView(title: "Accion")
}
