//
//  AuthorSearchItemView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct AuthorSearchItemView: View {
    let author: Author
    var body: some View {
        HStack {
            Image(systemName: "person.crop.square")
                .resizable()
                .frame(width: 30, height: 30)
            Text("\(author.firstName) \(author.lastName)")
                .font(.caption)
            Spacer()
        }
    }
}

#Preview {
    AuthorSearchItemView(author: Author.test)
}
