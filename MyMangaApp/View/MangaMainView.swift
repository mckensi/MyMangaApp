//
//  MangaMainView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import SwiftUI

struct MangaMainView: View {
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    var body: some View {
        switch deviceIdiom {
        case .pad:
            ConteViewIpad()
        default:
            ConteViewIphone()
        }
    }
}

#Preview {
    MangaMainView()
        .environment(MangaListVM.test)
        .environment(AccountVM.testLogin)
        .environment(MangaDetailVM.test)
        .environment(UserMangaCollectionVM.test)
}

struct ConteViewIphone: View {
    var body: some View {
        TabView {
            MangaListMainView()
                .tabItem {
                    Label("Lee ahora", systemImage: "book")
                }
            UserMangaCollectionView()
                .tabItem {
                    Label("Libreria", systemImage: "books.vertical")
                }
            MangasSearchView(vm: MangasSearchVM())
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ConteViewIpad: View {
    @State var selection: NavigationSplit.ID?
    @State var textToSearch = ""
    @State var showSearchDetail = false
    let options: [NavigationSplit] = [
        NavigationSplit(title: "Leer Ahora", id: 1),
        NavigationSplit(title: "Libreria", id: 2)
    ]
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(options) { option in
                    Text(option.title)
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
