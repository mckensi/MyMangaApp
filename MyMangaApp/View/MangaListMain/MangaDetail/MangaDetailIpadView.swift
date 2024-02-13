//
//  MangaDetailIpadView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 1/02/24.
//

import SwiftUI

struct MangaDetailIpadView: View {
    var vm: MangaDetailVM

    @State var showSelectVolumesView = false
    @State var showAccountView = false
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                HStack(alignment: .top) {
                    BookImage(url: vm.manga.mainPicture)
                    VStack(alignment: .leading) {
                        BookTitleRatingAuthorIpadView(manga: vm.manga, userManga: nil)
                        AddButtonView(
                            showSelectVolumesView: $showSelectVolumesView,
                            showAccountView: $showAccountView,
                            manga: vm.manga,
                            vm: vm
                        )
                        #if os(visionOS)
                        .hoverEffect()
                        .buttonStyle(.bordered)
                        #else
                        .buttonStyle(.plain)
                        #endif
                    }
                }
         
                BookDescriptionView(manga: vm.manga)
                BookCollectionDetailsView(manga: vm.manga)
                MoreBooksAuthorsGridView(authorsAndBooks: vm.authorsAndBooks, manga: vm.manga)
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
    .sheet(isPresented: $showSelectVolumesView, content: {
        MangasVolumeSelectionView(manga: vm.manga, detailVm: vm)
    })
    .sheet(isPresented: $showAccountView, content: {
        AccountView()
    })
    }
}

#Preview {
    MangaDetailIpadView(vm: MangaDetailVM.test)
        .environment(AccountVM.testAnonimous)
}
