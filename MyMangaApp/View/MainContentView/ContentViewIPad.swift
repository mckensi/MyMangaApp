//
//  ContentViewIPad.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 3/02/24.
//

import SwiftUI


struct ContentViewIPad: View {
    @State var selection: NavigationSplit.ID?
    @State var textToSearch = ""
    @State var showSearchDetail = false
    let options: [NavigationSplit] = [
        NavigationSplit(title: "Leer ahora", id: 1),
        NavigationSplit(title: "Librería", id: 2)
    ]
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(options) { option in
                    Text(LocalizedStringKey(option.title))
                }
            }
            .searchable(text: $textToSearch)
            .onSubmit(of: .search) {
                if !textToSearch.isEmpty {
                    showSearchDetail.toggle()
                }
            }
            .onChange(of: textToSearch) { oldValue, newValue in
                if newValue.isEmpty {
                    showSearchDetail.toggle()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        } detail: {
            if showSearchDetail {
                MangasSearchIpadView(vm: MangasSearchVM(), textToSearch: $textToSearch)
            } else {
                switch selection {
                case 1:
                    MangaListMainView()
                case 2:
                    UserMangaCollectionView()
                default:
                    MangaListMainView()
                }
            }

        }
    }
}

struct NavigationSplit: Identifiable, Hashable {
    let title: String
    let id: Int
}

#Preview {
    ContentViewIPad()
        .environment(MangaListVM.test)
        .environment(AccountVM.testLogin)
        .environment(MangaDetailVM.test)
        .environment(UserMangaCollectionVM.test)
}
