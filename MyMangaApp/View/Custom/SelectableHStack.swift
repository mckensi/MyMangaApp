//
//  SelectableHStack.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 20/01/24.
//

import SwiftUI

struct SelectableHStack: View {
    // Define un array con las opciones de texto
    let items: [String]
    let itemWidth: CGFloat = 80 // Ancho fijo para cada item
    let itemHeight: CGFloat = 30 // Altura fija para el indicador
    let itemSpace: CGFloat = 8
    // Almacena el índice del elemento seleccionado
    @Binding var selected: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Indicador de selección
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.red) // Color del indicador
                .frame(width: itemWidth, height: itemHeight) // Tamaño fijo del indicador
                .offset(x: CGFloat(selected) * (itemWidth + itemSpace), y: 0) // Desplazamiento basado en el elemento seleccionado
                .animation(.spring(), value: selected) // Animación de transición
            
            // HStack con elementos seleccionables
            HStack(spacing: itemSpace) { // Define espaciado entre elementos
                ForEach(0..<items.count, id: \.self) { index in
                    Text(items[index])
                        .frame(width: itemWidth, height: itemHeight)
                        .foregroundColor(selected == index ? .white : .black)
                        .background(Color.clear)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .onTapGesture {
                            self.selected = index
                        }
                }
                Spacer()
            }
        }
    }
}

struct SelectableHStack_Previews: PreviewProvider {

    static var previews: some View {
        ExampleView()
            .previewLayout(.sizeThatFits) // Para previsualizar el componente en su tamaño natural
    }
}

private struct ExampleView: View {
    @State private var selected = 0
    var items = ["Mangas", "Authors"]
    var body: some View {
        VStack {
            SelectableHStack(items: items, selected: $selected)
        }
    }
}
