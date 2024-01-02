//
//  ContentView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import SwiftUI

struct MangaListMainView: View {
    
    @Environment(MangaListVM.self) var vm
    @State var showAccountView = false
    var body: some View {
        @Bindable var bvm = vm
        
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(vm.mangasLogic.mangas) { manga in
                        NavigationLink(value: manga) {
                            MangaListItemView(manga: manga)
                        }
        
                    }
                }
                .padding()
            }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "person")
                    .font(.title)
                    .onTapGesture {
                        showAccountView.toggle()
                    }
            }
        }
        .navigationDestination(for: MangaItem.self) { manga in
            MangaDetailView(manga: manga)
        }
        }
        .navigationTitle("Librería")
        .alert("App Alert", isPresented: $bvm.showAlert) {}
        message: {
            Text(vm.alertMsg)
        }
        .sheet(isPresented: $showAccountView, content: {
            AccountView()
        })
    }
    
}

#Preview {
    MangaListMainView()
        .environment(MangaListVM.test)
        .environment(AccountVM())
        .environment(MangaDetailVM.test)
}

struct MangaListItemView: View {
    var manga: MangaItem
    var body: some View {
        VStack {
            AsyncImage(url: manga.mainPicture) { cover in
                cover
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
            } placeholder: {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            }
            Text(manga.title)
        }
    }
}
