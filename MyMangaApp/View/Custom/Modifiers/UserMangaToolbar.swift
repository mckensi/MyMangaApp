//
//  UserMangaToolbar.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct UserMangaToolbar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    var vm: UserMangaDetailVM
    var deleteComplation: () -> Void
    func body(content: Content) -> some View {
        content
            .toolbar {
                Menu {
                    Button(role: .destructive) {
                        Task {
                            vm.removeUserManga {
                                dismiss()
                                deleteComplation()
                            }
                        }
                    } label: {
                        HStack {
                            Text("Borrar de la biblioteca")
                                .foregroundStyle(.red)
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }
            label: {
                Image(systemName: "ellipsis.circle.fill")
                    .imageScale(.large)
            }
            }
    }
}


extension View {
    func userMangaToolbar(userMangaDetailVM: UserMangaDetailVM, dismissCompletion: @escaping () -> Void) -> some View {
        modifier(UserMangaToolbar(vm: userMangaDetailVM, deleteComplation: dismissCompletion))
    }
}

