//
//  ViewController.swift
//  iBeaconTest
//
//  Created by Guilherme Paciulli on 10/05/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var beaconsDistances = {"Beacon1": [], "Beacon2": [], "Beacon3": []}
    
    var b1: Double?
    
    var b2: Double?

    var b3: Double?


    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
        let beaconRegion1 = CLBeaconRegion(proximityUUID: uuid, major: 30969, minor: 18337, identifier: "Beacon1")
        let beaconRegion2 = CLBeaconRegion(proximityUUID: uuid, major: 33119, minor: 33895, identifier: "Beacon2")
        let beaconRegion3 = CLBeaconRegion(proximityUUID: uuid, major: 35079, minor: 46811, identifier: "Beacon3")

        locationManager.startMonitoring(for: beaconRegion1)
        locationManager.startRangingBeacons(in: beaconRegion1)
        
        locationManager.startMonitoring(for: beaconRegion2)
        locationManager.startRangingBeacons(in: beaconRegion2)
        
        locationManager.startMonitoring(for: beaconRegion3)
        locationManager.startRangingBeacons(in: beaconRegion3)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for beacon in beacons {
            if beacon.major == 33119 && beacon.minor == 33895 {
                b1 = beacon.accuracy
            } else if beacon.major == 30969 && beacon.minor == 18337 {
                b3 = beacon.accuracy
            } else if beacon.major == 35079 && beacon.minor == 46811 {
                b2 = beacon.accuracy
            }
        }
    }
}

