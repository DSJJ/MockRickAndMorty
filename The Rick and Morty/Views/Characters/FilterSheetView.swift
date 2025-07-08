//
//  FilterSheetView.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI

struct FilterSheetView: View {
  @Binding var filterStatus: String
  @Binding var filterSpecies: String
  var onApply: () -> Void
  
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    VStack(spacing: 0) {
      Form {
        Section(header: Text("Estado")) {
          Picker("Estado", selection: $filterStatus) {
            Text("Todos").tag("")
            Text("Vivo").tag("alive")
            Text("Muerto").tag("dead")
            Text("Desconocido").tag("unknown")
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Especie")) {
          Picker("Especie", selection: $filterSpecies) {
            Text("Todas").tag("")
            Text("Humano").tag("Human")
            Text("Alien").tag("Alien")
            Text("Robot").tag("Robot")
            Text("Animal").tag("Animal")
          }
        }
      }
      
      HStack(spacing: 12) {
        Button(action: {
          dismiss()
        }) {
          Text("Cancelar")
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(Color.red.opacity(0.2))
            .foregroundColor(.red)
            .clipShape(Capsule())
        }
        
        Button(action: {
          dismiss()
          onApply()
        }) {
          Text("Aplicar")
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(Color.green.opacity(0.2))
            .foregroundColor(.green)
            .clipShape(Capsule())
        }
      }
      .padding(.horizontal)
      .padding(.vertical, 12)
    }
    .presentationDetents([.height(300)])
    .presentationDragIndicator(.visible)
  }
}

#Preview {
  FilterSheetView(filterStatus: .constant("Todos"), filterSpecies: .constant("Todas"), onApply: {})
}
