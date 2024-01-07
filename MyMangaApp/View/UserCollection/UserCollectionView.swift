//
//  UserCollectionView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 29/12/23.
//

import SwiftUI

struct UserCollectionView: View {
    @Environment(UserMangaCollectionVM.self) var vm
    @Environment(AccountVM.self) var accountVm
    
    @State var showAccountView = false
    
    var body: some View {
        @Bindable var bvm = vm
        
        NavigationStack {
            Group {
                if accountVm.isUserLogged {
                    MangaUserCollectionItems(mangas: vm.mangasLogic.mangas, showAccountView: $showAccountView)
                } else {
                    Text("Inicia sesión para ver tu biblioteca")
                }
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
    UserCollectionView()
        .environment(UserMangaCollectionVM.test)
        .environment(AccountVM.testLogin)
}

struct MangaUserCollectionItems: View {
    var mangas: [MangaItem]
    @Binding var showAccountView: Bool
    var body: some View {
        ScrollView {
            VStack {
                ForEach(mangas) { manga in
                    NavigationLink(value: manga) {
                        MangaListItemView(manga: manga)
                    }
                    
                }
            }
            .padding()
        }
        .navigationDestination(for: MangaItem.self) { manga in
            UserMangaDetailView(vm: UserMangaDetailVM(id: manga.id))
        }
    }
}
