//
//  ViewController.swift
//  Project16
//
//  Created by Daniel Gx on 15/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnnotations()
        welcomeMap()
    }

    // MARK: - Methods
    
    func welcomeMap() {
        let ac = UIAlertController(title: "Welcome to World Map", message: "Please, set your favorite kind of map!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: setKindOfMap(_:)))
        ac.addAction(UIAlertAction(title: "Normal", style: .default, handler: setKindOfMap(_:)))
        present(ac, animated: true)
    }
    
    func setKindOfMap(_ sender: UIAlertAction) {
        if sender.title == "Satellite" {
            mapView.mapType = .satellite
        } else {
            mapView.mapType = .standard
        }
    }
    
    func setAnnotations() {
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        let brasilia = Capital(title: "Brazilia", coordinate: CLLocationCoordinate2D(latitude: -15.7801, longitude: -47.9292), info: "This is the best city around the world")
        mapView.addAnnotations([london, oslo, paris, rome, washington, brasilia])
    }
}

// MARK: - Map Cycle

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        annotationView?.pinTintColor = .systemPink
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let webCapitalView = WebCapitalView()
        webCapitalView.selectedURLParameter = capital.title
        navigationController?.pushViewController(webCapitalView, animated: true)
    }
}
