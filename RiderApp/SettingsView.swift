//
//  SettingView.swift
//  RiderApp
//
//  Created by jinseok PARK on 2023/02/14.
//

import SwiftUI

struct SettingsView: View {
    
//    @State var travalRadius: Double = 300
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var settings = SettingsManager()
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [.red, .pink]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))).frame(width: 100, height: 100)
                Image(systemName: "map").foregroundColor(.white).font(.largeTitle)
            }
            
            Text("Your Ride Expierence").font(.largeTitle).bold()
            Spacer().frame(height: 100)
            Text("How far do you like to drive?").bold()
            Slider(value: $settings.travelRadius, in: 100...500, step: 100)
            HStack {
                ForEach(0..<Int(settings.travelRadius/100), id: \.self) {
                    _ in
                    Image(systemName: "car").font(.largeTitle)
                }
            }.padding(.top, 10)
            Text("My Radius is \(Int(settings.travelRadius)) km").font(.headline).foregroundColor(.gray)
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {Text("Done").font(.title)})
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
