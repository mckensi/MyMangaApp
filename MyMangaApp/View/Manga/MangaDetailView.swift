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
            LazyVStack {
                BookImage(manga: manga)
                BookTitleRatingAuthor(manga: manga)
                AddCollectionButton(manga: manga)
                BookDescription(manga: manga)
                BookCollectionDetails(manga: manga)
                MoreBooksAuthorsGrid(manga: manga)
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
        vm.getBooksAllAuthors(authors: manga.authors)
    }
    .navigationDestination(for: MangaItem.self) { manga in
        MangaDetailView(manga: manga)
    }
    .navigationDestination(for: Author.self) { author in
        MangasByAuthorView(vm: MangasByAuthorVM(author: author))
    }
    }
}

#Preview {
    MangaDetailView(manga: .test)
        .environment(MangaDetailVM.test)
}

struct BookImage: View {
    let manga: MangaItem
    var body: some View {
        AsyncImage(url: manga.mainPicture) { cover in
            cover
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 30)
        } placeholder: {
            Image(systemName: "book")
                .resizable()
                .scaledToFit()
        }
        
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct BookTitleRatingAuthor: View {
    let manga: MangaItem
    var body: some View {
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
    }
}

struct AddCollectionButton: View {
    @Environment(MangaDetailVM.self) var vm
    let manga: MangaItem
    var body: some View {
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
    }
}

struct BookDescription: View {
    let manga: MangaItem
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Descripción")
                .font(.headline)
            Text(manga.sypnosis ?? "")
        }
        .padding()
    }
}

struct BookCollectionDetails: View {
    let manga: MangaItem
    var body: some View {
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
    }
}

struct MoreBooksAuthorsGrid: View {
    
    let gridItem = GridItem(.adaptive(minimum: 240))
    @Environment(MangaDetailVM.self) var vm
    let manga: MangaItem
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(vm.authorsAndBooks) { authorAndManga in
                NavigationLink(value: authorAndManga.author) {
                    HStack {
                        Text("Mas de \(authorAndManga.author.firstName) \(authorAndManga.author.lastName)")
                            .font(.headline)
                        Image(systemName: "chevron.right")
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    }
            
                }
                .tint(.black)
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [gridItem], spacing: 20) {
                        ForEach(
                            authorAndManga.mangas
                        ) { manga in
                            NavigationLink(value: manga) {
                                MangaListItemView(showDescription: true, manga: manga)
                            }
                        }
                    }
                }
                .tint(.black)
            }
          
   
        }
        .padding(.horizontal)
    }
}
