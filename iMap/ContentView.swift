//
//  ContentView.swift
//  iMap
//
//  Created by ksd on 11/03/2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var cameraPosition: MapCameraPosition = .automatic
    @State private var mapMarkerSelection: Int?

    @Environment(LocationController.self) var locationManager

    var body: some View {
        MapReader { reader in
            Map(position: $cameraPosition, selection: $mapMarkerSelection){
                Marker(coordinate: .erhvervsakademiAarhus) {
                    Image(systemName: "house.and.flag.fill")
                }.tag(1)

                Marker(coordinate: .moulinRouge) {
                    Image(systemName: "figure.stand.dress")
                }.tag(2)
            }
            .mapControls({
                MapUserLocationButton()
            })
            .onTapGesture { screenCoord in
                let location = reader.convert(screenCoord, from: .local)
                print("Du er her: \(location?.latitude), \(location?.longitude)")
            }
            .onChange(of: cameraPosition, { oldValue, newValue in
                print("Kortet ændrede sig")
            })
            .onChange(of: mapMarkerSelection, { oldValue, newValue in
                print("Du klikkede på marker \(newValue)")
            })
            .mapStyle(.standard)
        }
    }
}

#Preview {
    ContentView().environment(LocationController())
}
