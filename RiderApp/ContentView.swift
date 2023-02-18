//
//  ContentView.swift
//  RiderApp
//
//  Created by jinseok PARK on 2023/02/08.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    
    @ObservedObject var dm = DistanceManager()
    
    @State private var showSettings = false
    
    @ObservedObject var settings = SettingsManager()
    
    var body: some View {
        VStack {
            ZStack {
                MapView(centerCoordinate: $centerCoordinate, mapAnnotations: locations).edgesIgnoringSafeArea(.all)
//                Rectangle().fill(Color.gray).edgesIgnoringSafeArea(.all)
                Circle().fill(Color.blue).opacity(0.3).frame(width: 30, height: 30)
            }
            Button(action: {
                let newLocation = MKPointAnnotation()
                newLocation.coordinate = self.centerCoordinate
                self.locations.append(newLocation)
                
                if self.locations.count == 2 {
                    let locationA = CLLocation(latitude: self.locations.first!.coordinate.latitude, longitude: self.locations.first!.coordinate.longitude)
                    let locationB = CLLocation(latitude: self.locations.last!.coordinate.latitude, longitude: self.locations.last!.coordinate.longitude)
                    
                    self.dm.distance([locationA, locationB])
                } else if self.locations.count > 2 {
                    self.dm.distance = 0
                    self.locations.removeAll()
                }
            }) {
                if self.locations.count != 2 {
                    Image(systemName: "plus")
                } else {
                    Image(systemName: "trash")
                }
            }
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.title)
            .clipShape(Circle())
            .padding(.top, -35)
            Text("Distance Evaluation").font(.title).bold()
//            Circle().frame(width: 300, height: 300)
            
            ZStack {
                RingView(percentage: (dm.distance ?? 0) / Double(settings.travelRadius), startColor: .red, endColor: .pink).aspectRatio(contentMode: .fit)
                if dm.distance != 0 {
                    Text("\(Int(dm.distance ?? 0)) km").font(.title).bold()
                }
            }
            
            HStack {
                Spacer()
                Button(action: {
                    self.showSettings.toggle()
                }, label: {
                    Image(systemName: "gear")
                }).sheet(isPresented: $showSettings, content: {
                    SettingsView()
                })
            }.padding(.trailing, 20)
        }
    }
}

    // add github RiderApp

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

