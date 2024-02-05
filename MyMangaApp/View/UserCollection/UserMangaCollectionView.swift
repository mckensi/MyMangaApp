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
                    MangaUserCollectionItemsView(mangas: vm.mangasLogic.mangas, deleteComplation: {
                        Task { await vm.getData() }
                    }, showAccountView: $showAccountView)
                } else {
                    Text("Inicia sesión para ver tu biblioteca")
                }
            }
            .profileToolBarItem(accountVM: accountVm, showAccountView: $showAccountView)
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
