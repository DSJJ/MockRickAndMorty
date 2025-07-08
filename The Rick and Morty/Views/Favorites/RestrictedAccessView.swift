//
//  RestrictedAccessView.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI

struct RestrictedAccessView: View {
  let onRetry: () -> Void
  
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "lock.shield")
        .resizable()
        .frame(width: 100, height: 100)
        .foregroundColor(.red)
      
      Text("Acceso restringido")
        .font(.title2)
        .bold()
      
      Button(action: onRetry) {
        Text("Reintentar")
          .padding()
          .frame(maxWidth: .infinity)
          .background(Capsule().fill(Color.blue))
          .foregroundColor(.white)
          .padding(.horizontal)
      }
    }
    .padding()
  }
}

#Preview {
  RestrictedAccessView(onRetry: {})
}
