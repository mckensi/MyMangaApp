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
                            CategoryTitleView(title: genre.genre)
                        }
                        .buttonStyle(.plain)
                        .hoverEffect()
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
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
                #if os(visionOS)
                .padding(.horizontal)
                #endif
                .padding()
            }
            .navigationDestination(for: MangaItem.self) { manga in
                switch deviceIdiom {
                case .pad:
                    MangaDetailIPadView(vm: MangaDetailVM(manga: manga))
                case .vision:
                    MangaDetailIPadView(vm: MangaDetailVM(manga: manga))
                default:
                    MangaDetailView(vm: MangaDetailVM(manga: manga))
                }
               
            }
            .navigationDestination(for: Author.self) { author in
                MangasByAuthorView(vm: MangasByAuthorVM(author: author))
            }
            .navigationDestination(for: Genre.self) { genre in
                MangasByCategoryView(vm: MangasByCategoryVM(network: Network(), genre: genre.genre))
            }
            .profileToolBarItem(accountVM: accountVm, showAccountView: $showAccountView)
            #if os(visionOS)
            .offset(z: 20)
            #endif
            .navigationTitle(
                "Leer ahora"
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
}
