//
//  LoginView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 26/12/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AccountVM.self) var vm
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isValid = false
    
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            VStack {
                MangaTextField(label: "Correo", text: $email, validator: Validators.shared.validEmail(_:), keyType: .emailAddress)
                MangaTextField(label: "Contraseña", text: $password, validator: Validators.shared.greaterThan4(_:))
                Button(role: .none) {
                    if isValid {
                        vm.loginUser(email: email, password: password) {
                            Task {
                                dismiss()
                            }
                        }
                    }
                } label: {
                    Text("Continuar")
                        .foregroundStyle(isValid ? .blue : .secondary)
                }
                
            }
            .padding()
            .navigationTitle("Iniciar sesión")
            .alert("App Alert", isPresented: $bvm.showAlert) {
                
            }
            message: {
                Text(vm.alertMsg)
            }
            .onChange(of: email) { oldValue, newValue in
                isValid = vm.fieldsAreValid(email: email, password: password)
            }
            .onChange(of: password) { oldValue, newValue in
                isValid = vm.fieldsAreValid(email: email, password: password)
            }
        }
    }
}

#Preview {
    NavigationView {
        LoginView()
            .environment(AccountVM())
    }
}
