//
//  CharacterMapView.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI
import MapKit

struct CharacterLocation: Identifiable {
  let id = UUID()
  let name: String
  let coordinate: CLLocationCoordinate2D
}

struct CharacterMapView: View {
  let location: CharacterLocation
  
  @State private var region: MKCoordinateRegion
  
  init(location: CharacterLocation) {
    self.location = location
    _region = State(initialValue: MKCoordinateRegion(
      center: location.coordinate,
      span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
  }
  
  var body: some View {
    Map(initialPosition: .region(region)) {
      Marker(location.name, coordinate: location.coordinate)
    }
    .mapControls {
      MapUserLocationButton()
      MapPitchToggle()
      MapCompass()
    }
    .edgesIgnoringSafeArea(.all)
    .overlay(alignment: .top) {
      Text(location.name)
        .font(.title2)
        .bold()
        .padding()
        .background(.ultraThinMaterial)
    }
  }
}

#Preview {
  CharacterMapView(location: CharacterLocation(
    name: "Rick Sanchez",
    coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)
  ))
}
