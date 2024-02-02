//
//  ContentView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 19/12/23.
//

import SwiftUI

struct MangaListMainView: View {
    
    
    @Environment(MangaListVM.self) var vm
    @Environment(AccountVM.self) var accountVm
    @State var showAccountView = false
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 240))
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    
    
    var body: some View {
        @Bindable var bvm = vm
        
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(
                        vm.mangasLogic.getGenres(
                            mangas: vm.mangasLogic.mangas
                        )
                    ) { genre in
                        NavigationLink(value: genre) {
                            HStack {
                                CategoryTitleView(genre: genre)
                            }
                        }
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [itemAdaptativeTypes], spacing: 20) {
                                ForEach(
                                    vm.mangasLogic.getMangasByGenre(
                                        genre: genre.genre
                                    )
                                ) { manga in
                                    NavigationLink(value: manga) {
                                        MangaListItemView(manga: manga)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                .tint(.black)
                .padding()
            }
            .navigationDestination(for: MangaItem.self) { manga in
                switch deviceIdiom {
                case .pad:
                    MangaDetailIpadView(manga: manga)
                default:
                    MangaDetailView(manga: manga)
                }
               
            }
            .navigationDestination(for: Genre.self) { genre in
                MangasByCategoryView(vm: MangasByCategoryVM(network: Network(), genre: genre.genre))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if accountVm.isUserLogged {
                        Image("userProfile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .onTapGesture {
                                showAccountView.toggle()
                            }
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .font(.title)
                            .onTapGesture {
                                showAccountView.toggle()
                            }
                    }
                }
            }
            .navigationTitle(
                "Librería"
            )
        }
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
        .environment(AccountVM.testLogin)
        .environment(MangaDetailVM.test)
}

struct CategoryTitleView: View {
    let genre: Genre
    var body: some View {
        HStack {
            Text(genre.genre)
                .font(.title2)
                .bold()
            Image(systemName: "chevron.right")
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}
