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
    let gridItem = GridItem(.adaptive(minimum: 240))
    
    var body: some View {
        @Bindable var bvm = vm
        NavigationStack {
            ScrollView {
                LazyVStack {
                    AsyncImage(url: manga.mainPicture) { cover in
                        cover
                            .resizable()
                            .scaledToFit()
                            .frame(width: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal, 30)
                    } placeholder: {
                        Image(systemName: "book")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    }
                    
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .center) {
                        Text(manga.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        ForEach(manga.authors) { author in
                            Text("\(author.firstName) \(author.lastName)")
                        }
                        Text("Calificación: \(Int(manga.score))/10")
                            .foregroundStyle(.secondary)
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    Button("Agregar", role: .none) {
                        Task {
                            await vm.addMangaToLibrary(manga: manga)
                        }
                    }
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .frame(width: 300, height: 52)
                    .background {
                        RoundedRectangle(cornerRadius: 26)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descripción")
                            .font(.headline)
                        Text(manga.sypnosis ?? "")
                    }
                    .padding()
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            VStack(spacing: 10) {
                                Text("Género".uppercased())
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.secondary)
                                Text(manga.genres.first?.genre ?? "")
                            }
                            VStack(spacing: 10) {
                                Text("Volumenes".uppercased())
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.secondary)
                                Text("\(manga.volumes ?? 1)")
                            }
                            VStack(spacing: 10) {
                                Text("Capítulos".uppercased())
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.secondary)
                                Text("\(manga.chapters ?? 1)")
                            }
                            VStack(spacing: 10) {
                                Text("Temas".uppercased())
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.secondary)
                                ForEach(manga.themes) { theme in
                                    Text(theme.theme)
                                }
                            }
                        }
                        .padding()
                    }
                    VStack(alignment: .leading) {
                        Text("Mas libros de \(manga.authors.first?.firstName ?? "")")
                            .font(.headline)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [gridItem], spacing: 20) {
                                ForEach(
                                    vm.authorBooks
                                ) { manga in
                                    NavigationLink(value: manga) {
                                        MangaListItemView(showDescription: true, manga: manga)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
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
            .onAppear {
                if let idAuthor = manga.authors.first?.id {
                    vm.getBooksByAuthor(id: idAuthor)
                }
            }
            .navigationDestination(for: MangaItem.self) { manga in
                MangaDetailView(manga: manga)
            }
        }
    }
}

#Preview {
    MangaDetailView(manga: .test)
        .environment(MangaDetailVM.test)
}
