//
//  ViewController.swift
//  Project22
//
//  Created by Daniel Gx on 09/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var distanceReading: UILabel!
    var locationManager: CLLocationManager?
    var beaconLocalized: Bool = false
    
    var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.widthAnchor.constraint(equalToConstant: 256).isActive = true
        view.heightAnchor.constraint(equalToConstant: 256).isActive = true
        view.layer.cornerRadius = 128
        view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIFeatures()
        setupLocation()
        view.addSubview(circleView)
    }
    
    // MARK: - Methods
    
    func startScanning() {
        /// WARNING: Put your beacon data below!!!
        let firstuuid = UUID(uuidString: "972E5347-88F2-48FF-8841-13C535A28C76")!
        let firstBeaconRegion = CLBeaconRegion(uuid: firstuuid, major: 16808, minor: 19400, identifier: "MyBeacon")
        ///
        let seconduuid = UUID(uuidString: "E1D7F24E-3A06-4D19-B012-29F9ABD90A53")!
        let secondBeaconRegion = CLBeaconRegion(uuid: seconduuid, major: 16808, minor: 19400, identifier: "SecondBeacon")
        
        locationManager?.startMonitoring(for: secondBeaconRegion)
        locationManager?.startRangingBeacons(satisfying: firstBeaconRegion.beaconIdentityConstraint)
    }
    
    func showFirstDetection(identifier: String) {
        if beaconLocalized {
            beaconLocalized = false
            let ac = UIAlertController(title: "Beacon detected", message: identifier, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}

// MARK: - Location Manager

extension ViewController: CLLocationManagerDelegate {
    private func setupUIFeatures() {
        view.backgroundColor = .gray
    }
    
    private func setupLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
            showFirstDetection(identifier: region.identifier)
        } else {
            update(distance: .unknown)
        }
    }
    
    func update(distance: CLProximity) {
        
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.distanceReading.text = "FAR"
                self.circleView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReading.text = "NEAR"
                self.circleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReading.text = "RIGHT HERE"
                self.circleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            default:
                self.view.backgroundColor = UIColor.gray
                self.distanceReading.text = "UNKNOWN"
                self.circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)

            }
        }
    }
}

