//
//  MapView.swift
//  RiderApp
//
//  Created by jinseok PARK on 2023/02/08.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
        
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var mapAnnotations: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
//        mapView.setCenter(CLLocationCoordinate2DMake(37.334903, -122.008687), animated: true)
        mapView.setCenter(CLLocationCoordinate2DMake(35.22994, 128.50671), animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if mapAnnotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(mapAnnotations)
            
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var mapViewParent: MapView
        init (_ parent: MapView) {
            self.mapViewParent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            mapViewParent.centerCoordinate = mapView.centerCoordinate
        }
    }
}

extension MKPointAnnotation {
    static var appleParkExample: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "distoma's House"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.22994, longitude: 128.50671)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.appleParkExample.coordinate), mapAnnotations: [MKPointAnnotation.appleParkExample])
//        MapView(centerCoordinate: MKPointAnnotation.appleParkExample.coordinate, mapAnnotations: [MKPointAnnotation.appleParkExample])
    }
}
