//
//  VolumesSelectionListView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct VolumesSelectionListView: View {
    let manga: MangaItem
    var vm: MangasVolumeSelectionVM
    var body: some View {
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
                            .onTapGesture {
                                vm.selectAllVolumes(volumes: manga.volumes ?? 1)
                            }
                    }
                }
                VolumesListView(vm: vm, volumes: manga.volumes ?? 0)
            }
        }
    }
}

struct VolumesListView: View {
    var vm: MangasVolumeSelectionVM
    let volumes: Int
    var body: some View {
        VStack {
            ForEach(1..<(volumes) + 1, id: \.self) { volume in
                VStack {
                    HStack {
                        Text("\(volume)")
                        Spacer()
                        Button {
                            vm.addVolume(volume: volume)
                        } label: {
                            Image(systemName: vm.mangasLogic.mangasSelected.contains(volume) ? "checkmark.circle.fill" : "circle")
                        }
                        .hoverEffect()
                        .buttonStyle(.plain)
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
}


#Preview {
    VolumesSelectionListView(manga: MangaItem.test, vm: MangasVolumeSelectionVM())
}
