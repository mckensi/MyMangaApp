//
//  MangaDetailView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import SwiftUI

struct MangaDetailView: View {
    
    var manga: MangaItem

    @Environment(MangaDetailVM.self) var vm
    
    var body: some View {
        @Bindable var bvm = vm
        ScrollView {
            VStack {
                AsyncImage(url: manga.mainPicture) { cover in
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
                Text(manga.title)
                Button("Anadir a biblioteca", role: .none) {
                    Task {
                        await vm.addMangaToLibrary(manga: manga)
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
    MangaDetailView(manga: .test)
        .environment(MangaDetailVM.test)
}
