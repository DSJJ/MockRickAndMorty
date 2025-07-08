//
//  CapsuleCell.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI

struct CapsuleCell: View {
  let imageURL: String
  let name: String
  let species: String
  let status: String
  
  var body: some View {
    HStack(spacing: 16) {
      AsyncImage(url: URL(string: imageURL)) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
      } placeholder: {
        ProgressView()
      }
      .frame(width: 80, height: 80)
      .clipShape(Circle())
      
      VStack(alignment: .leading, spacing: 4) {
        Text(name)
          .font(.headline)
        
        Text(species)
          .font(.subheadline)
          .foregroundColor(.secondary)
        
        HStack(spacing: 6) {
          Circle()
            .fill(color(for: status))
            .frame(width: 10, height: 10)
          Text(status.capitalized)
            .font(.caption)
            .foregroundColor(color(for: status))
        }
      }
      
      Spacer()
    }
    .background(Color(.secondarySystemBackground))
    .clipShape(Capsule())
    .overlay(
      Capsule()
        .stroke(color(for: status), lineWidth: 2)
    )
    .padding(.horizontal)
    .padding(.vertical, 4)
  }
  
  private func color(for status: String) -> Color {
    switch status.lowercased() {
    case "alive": return .green
    case "dead": return .red
    default: return .gray
    }
  }
}

#Preview {
  CapsuleCell(imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
              name: "Rick Sanchez",
              species: "Human",
              status: "Alive",)
}
