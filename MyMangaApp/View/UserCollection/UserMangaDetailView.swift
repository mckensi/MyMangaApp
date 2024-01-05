//
//  UserMangaDetailView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia on 4/01/24.
//

import SwiftUI

struct UserMangaDetailView: View {

    var vm: UserMangaDetailVM
    
    var body: some View {
        @Bindable var bvm = vm
        ScrollView {
            VStack {
                AsyncImage(url: vm.userManga?.manga.mainPicture) { cover in
                    cover
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                    
                } placeholder: {
                    Image(systemName: "book")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
                Text(vm.userManga?.manga.title ?? "")
                Button("Borrar de la biblioteca", role: .destructive) {
                    Task {
                        print("borrando")
                    }
                }
            }
        }
        .alert("App Alert", isPresented: $bvm.showAlert) {
            
        }
        message: {
            Text(vm.alertMsg)
        }
        .alert("Manga agregado.", isPresented: $bvm.showSuccessAddedMangaAlert) {
            
        }
        message: {
            Text("El Manga ha sido agregado a tu colección.")
        }
    }
}

#Preview {
    UserMangaDetailView(vm: UserMangaDetailVM.test)
}
