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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
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
            self?.selectedLocationCoordinate = coordinate
        }
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
