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
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIFeatures()
        setupLocation()
    }
    
    // MARK: - Methods
    
    func startScanning() {
        /// WARNING: Put your beacon data below!!!
        let uuid = UUID(uuidString: "EE895FB2-86BE-4CEE-80ED-F0CBC7FAD1AE")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 16808, minor: 19400, identifier: "MyBeacon")
        ///
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
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
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReading.text = "NEAR"
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReading.text = "RIGHT HERE"
                
            default:
                self.view.backgroundColor = UIColor.gray
                self.distanceReading.text = "UNKNOWN"
            }
        }
    }
}

