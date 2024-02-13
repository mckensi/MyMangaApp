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
        NavigationSplit(title: "Busqueda", id: 0),
        NavigationSplit(title: "Leer ahora", id: 1),
        NavigationSplit(title: "Librería", id: 2)
    ]
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(options) { option in
                    if option.id != 0 {
                        Text(LocalizedStringKey(option.title))
                    }
                }
            }
            .searchable(text: $textToSearch)
            .onSubmit(of: .search) {
                if !textToSearch.isEmpty {
                    selection = 0
                }
            }
            .onChange(of: textToSearch) { oldValue, newValue in
                if newValue.isEmpty {
                    selection = 1
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        } detail: {
            switch selection {
            case 0:
                MangasSearchIPadView(vm: MangasSearchVM(), textToSearch: $textToSearch)
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

struct NavigationSplit: Identifiable, Hashable {
    let title: String
    let id: Int
}

#Preview {
    ContentViewIPad()
        .environment(MangaListVM.test)
        .environment(AccountVM.testLogin)
        .environment(UserMangaCollectionVM.test)
}
