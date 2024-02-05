//
//  VolumeReadingListView.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 5/02/24.
//

import SwiftUI

struct VolumeReadingListView: View {
    var vm: MangasVolumeSelectionVM
    let volumes: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Que volumen estas leyendo?")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 10)
            ForEach(1..<(volumes) + 1, id: \.self) { volume in
                VStack {
                    HStack {
                        Text("\(volume)")
                        Spacer()
                        Button {
                            vm.selectReadingVolume(volume: volume)
                            if !vm.mangasLogic.mangasSelected.contains(volume) {
                                vm.addVolume(volume: volume)
                            }
                        } label: {
                            Image(systemName: vm.mangasLogic.mangaReading == volume ? "checkmark.circle.fill" : "circle")
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
    VolumeReadingListView(vm: MangasVolumeSelectionVM(), volumes: 10)
}
