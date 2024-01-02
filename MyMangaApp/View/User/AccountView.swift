//
//  AccountView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 21/12/23.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AccountVM.self) var vm
    var body: some View {
        NavigationStack {
            Group {
                if vm.isUserLogged {
                    ScrollView {
                        VStack {
                            Image(systemName: "person")
                            Text(vm.getEmail())
                            Button("Cerrar sesión", role: .destructive) {
                                vm.closeSession {
                                    dismiss()
                                }
                            }
                        }
                    }
                } else {
                    List {
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Iniciar sesión")
                        }
                        
                        NavigationLink {
                            CreateUserView()
                        } label: {
                            Text("Crear usuario nuevo")
                        }

                    }
                }
            }
            .navigationTitle("Cuenta")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationView {
        AccountView()
            .environment(AccountVM())
    }
}
