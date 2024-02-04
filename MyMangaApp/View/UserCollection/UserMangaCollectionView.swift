//
//  UserCollectionView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 29/12/23.
//

import SwiftUI

struct UserMangaCollectionView: View {
    @Environment(UserMangaCollectionVM.self) var vm
    @Environment(AccountVM.self) var accountVm
    
    @State var showAccountView = false
    
    var body: some View {
        @Bindable var bvm = vm
        
        NavigationStack {
            Group {
                if accountVm.isUserLogged {
                    MangaUserCollectionItems(mangas: vm.mangasLogic.mangas, deleteComplation: {
                        Task { await vm.getData() }
                    }, showAccountView: $showAccountView)
                } else {
                    Text("Inicia sesión para ver tu biblioteca")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if accountVm.isUserLogged {
                        Button {
                            showAccountView.toggle()
                        } label: {
                            Image("userProfile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .buttonStyle(.plain)
                        .hoverEffect()
                        #if os(visionOS)
                        .offset(z: 20)
                        #endif
                    } else {
                        Button {
                            showAccountView.toggle()
                        } label: {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .font(.title)
                        }
                        .buttonStyle(.plain)
                        .hoverEffect()
                        #if os(visionOS)
                        .offset(z: 20)
                        #endif
                    }
                }
            }
        }
        .navigationTitle("Librería")
        .alert("App Alert", isPresented: $bvm.showAlert) {}
        message: {
            Text(vm.alertMsg)
        }
        .sheet(isPresented: $showAccountView, onDismiss: {
            if accountVm.isUserLogged {
                Task { await vm.getData() }
            }
        }, content: {
            AccountView()
        })
        .onAppear {
            if accountVm.isUserLogged {
                Task { await vm.getData() }
            }
        }
    }
}

#Preview {
    UserMangaCollectionView()
        .environment(UserMangaCollectionVM.test)
        .environment(AccountVM.testLogin)
}

struct MangaUserCollectionItems: View {
    var mangas: [MangaItem]
    var deleteComplation: () -> Void
    @Binding var showAccountView: Bool
    let itemAdaptativeTypes = GridItem(.adaptive(minimum: 190), spacing: 8)
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [itemAdaptativeTypes], spacing: 8) {
                ForEach(
                    mangas
                ) { manga in
                    NavigationLink(value: manga) {
                        MangaListItemView(manga: manga)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationDestination(for: MangaItem.self) { manga in
            UserMangaDetailView(vm: UserMangaDetailVM(id: manga.id), deleteComplation: {
                deleteComplation()
            })
        }
    }
}
