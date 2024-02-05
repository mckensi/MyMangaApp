//
//  ProfileToolBarItem.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 3/02/24.
//

import SwiftUI

struct ProfileToolBarItem: ViewModifier {
    var accountVm: AccountVM
    @Binding var showAccountView: Bool
    func body(content: Content) -> some View {
        content
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
}


extension View {
    func profileToolBarItem(accountVM: AccountVM, showAccountView: Binding<Bool>) -> some View {
        modifier(ProfileToolBarItem(accountVm: accountVM, showAccountView: showAccountView))
    }
}
