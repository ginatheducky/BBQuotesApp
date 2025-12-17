//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Gina on 17.12.25.
//

// one thing that makes a view model different to what people would call a controller:
// a view model is observable to the view, meaning the view treats the view models properties as its own in a certain way
// we should consider access control since we are making this file observable to other views

import Foundation


@Observable // with this we make the view model obersavable to the view
// now every single property we put in the ViewModel is act like a state property on our view
// observable makes all the properties state properties, meaning that when they change, the view is alerted and it triggers a refresh of the view
@MainActor // we want to make sure the viewmodel is fast since it has so much control over the UI
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(error: Error) // we can attach data to enum cases
    }
    
    // property to track our fetch status
    // we want the view to be able to see the property but not change it
    private(set) var status: FetchStatus = .notStarted // this property is partially private, so only the setting capability is private
    
    // we need to initialize a fetch service
    private let fetcher = FetchService()
    
    // we need some properties to store the data that we fetch
    var quote: Quote
    var character: Char
    
    init() {
        // this runs automatically as soon as the class gets initialized
    }
}
