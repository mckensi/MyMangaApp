//
//  MangaVolumeSelectionView.swift
//  MyMangaApp
//
//  Created by Daniel Murcia Almanza on 27/01/24.
//

import SwiftUI

struct MangaVolumeSelectionView: View {
    let mangaTitle: String
    let volumes: Int
    
    var vm: MangasVolumeSelectionVM = MangasVolumeSelectionVM()
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("Que volumenes quieres?")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                    HStack {
                        Spacer()
                        Button(role: .none) {
                            print()
                        } label: {
                            Text("Seleccionar todos")
                                .font(.caption)
                                .foregroundStyle(.red)
                                .multilineTextAlignment(.trailing)
                                .padding(.bottom, 30)
                        }
                    }
                    ForEach(1..<volumes + 1) { volume in
                        VStack {
                            HStack {
                                Text("\(volume)")
                                Spacer()
                                Image(systemName: vm.mangasLogic.mangasSelected.contains(volume) ? "checkmark.circle.fill" : "circle")
                                    .onTapGesture {
                                        vm.addVolume(volume: volume)
                                    }
              
                            }
                            if volume != volumes {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundStyle(Color.primary.opacity(0.1))
                            }
                         
                        }
                  
                    }
                }
            }
            Section {
                VStack(alignment: .leading) {
                    Text("Que volumen estas leyendo?")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                    ForEach(1..<volumes + 1) { volume in
                        VStack {
                            HStack {
                                Text("\(volume)")
                                Spacer()
                                Image(systemName: vm.mangasLogic.mangaReading == volume ? "checkmark.circle.fill" : "circle")
                                    .onTapGesture {
                                        vm.selectReadingVolume(volume: volume)
                                    }
              
                            }
                            if volume != volumes {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundStyle(Color.primary.opacity(0.1))
                            }
                        }
                  
                    }
                }
            }
            Button("Añadir", role: .none) {
                
            }
            .tint(.red)
        }
        .navigationTitle("Volumenes de \(mangaTitle)")
    }
}

#Preview {
    NavigationView(content: {
        MangaVolumeSelectionView(mangaTitle: MangaItem.test.title, volumes:  MangaItem.test.volumes ?? 1)
    })
}
