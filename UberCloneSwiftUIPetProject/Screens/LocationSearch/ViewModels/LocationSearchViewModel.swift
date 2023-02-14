//
//  LocationSearchViewModel.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 11.02.23.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    // MARK: — Public Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime: String?
    @Published var dropTime: String?
    
    var queryFragment = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    // MARK: — Private properties
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    // MARK: — Initialization
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // MARK: — Public methods
    
    func selectLocation(_ localSearchCompletion: MKLocalSearchCompletion) {
        searchLocation(from: localSearchCompletion) { [weak self] response, error in
            if let error = error { print("DEBUG: Location search failed with error: \(error.localizedDescription)") }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self?.selectedUberLocation = UberLocation(title: localSearchCompletion.title, coordinate: coordinate)
        }
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
            self.configurePickUpAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickUpAndDropOffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        pickupTime = formatter.string(from: Date())
        dropTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
    // MARK: — Private methods
    
    private func searchLocation(from searchCompletion: MKLocalSearchCompletion, completionHandler: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchCompletion.title.appending(searchCompletion.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completionHandler)
    }
}

// MARK: — MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
    }
}
