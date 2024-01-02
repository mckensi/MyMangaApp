//
//  ProfileVM.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 21/12/23.
//

import Foundation
import SwiftUI

@Observable
final class AccountVM {
    let network: DataInteractor
    let user: UserInteractor
    
    var alertMsg: String = ""
    var showAlert: Bool = false
    var isUserLogged = false
    
    init(network: DataInteractor = Network(), user: UserInteractor = User()) {
        self.network = network
        self.user = user
    }
    
    
    func createUser(email: String, password: String) {
        Task {
            do {
                try await network.createUser(email: email, password: password)
            } catch {
                print(error)
                await MainActor.run {
                    self.alertMsg = "\(error)"
                    self.showAlert.toggle()
                }
            }
        }
    }
    
    func loginUser(email: String, password: String, success: @escaping () -> Void) {
        Task {
            do {
                let token = try await network.login(email: email, password: password)
                try User.shared.saveToken(token: token, account: email)
                try User.shared.saveEmail(email: email)
                isUserLogged = true
                success()
            } catch {
                print(error)
                await MainActor.run {
                    self.alertMsg = "\(error)"
                    self.showAlert.toggle()
                }
            }
        }
    }
    
    func fieldsAreValid(email: String, password: String) -> Bool {
        if Validators.shared.validEmail(email) != nil {
            if Validators.shared.greaterThan4(password) != nil {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    func getEmail() -> String {
        do {
            return try User.shared.getEmail() ?? ""
        } catch {
            print(error.localizedDescription)
            self.alertMsg = "\(error)"
            self.showAlert.toggle()
            return ""
        }
    }
    
    func closeSession(completion: @escaping () -> Void) {
        do {
            try User.shared.closeSession()
            isUserLogged = false
            completion()
        } catch {
            print(error)
            self.alertMsg = "\(error)"
            self.showAlert.toggle()
        }
    }
}

