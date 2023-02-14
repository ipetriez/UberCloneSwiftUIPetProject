//
//  UberMapViewRepresentable.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 10.02.23.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    // MARK: — Private properties
    
    @EnvironmentObject private var locationSearchViewModel: LocationSearchViewModel
    @EnvironmentObject private var locationManager: LocationManager
    @Binding var mapViewState: MapViewState
    
    // MARK: — Public properties
    
    let mapView = MKMapView()
    
    // MARK: — Public methods
    
    func makeUIView(context: Context) -> some UIView {
        
        mapView.isRotateEnabled = false
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapViewState {
        case .noInput:
            context.coordinator.clearMapView()
        case .searchingForLocation:
            break
        case .locationSelected:
            if let selectedLocationCoordinate = locationSearchViewModel.selectedLocationCoordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: selectedLocationCoordinate)
                context.coordinator.configurePolyline(with: selectedLocationCoordinate)
            }
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: — Private properties
        
        private let parent: UberMapViewRepresentable
        private var userLocationCoordinate: CLLocationCoordinate2D?
        private var currentRegion: MKCoordinateRegion?
        
        // MARK: — Initialization
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: — MKMapViewDelegate methods
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), latitudinalMeters: 0.05, longitudinalMeters: 0.05)
            parent.mapView.setRegion(region, animated: true)
            currentRegion = region
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 6
            return renderer
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }
        
        func getRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (MKRoute) -> Void) {
            let userPlaceMark = MKPlacemark(coordinate: userLocation)
            let destinationPlaceMark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlaceMark)
            request.destination = MKMapItem(placemark: destinationPlaceMark)
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let error = error { print("DEBUG: Failed to get directions with error: \(error.localizedDescription)") }
                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }
        
        func configurePolyline(with destinationCoordinate: CLLocationCoordinate2D) {
            parent.mapView.removeOverlays(parent.mapView.overlays)
            guard let userLocationCoordinate = userLocationCoordinate else { return }
            getRoute(from: userLocationCoordinate, to: destinationCoordinate) { [weak self] route in
                self?.parent.mapView.addOverlay(route.polyline)
                if let rect = self?.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32)) {
                    self?.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                }
            }
        }
        
        func clearMapView() {
            parent.mapView.removeOverlays(parent.mapView.overlays)
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            if let region = currentRegion {
                parent.mapView.setRegion(region, animated: true)
            }
        }
    }
}


