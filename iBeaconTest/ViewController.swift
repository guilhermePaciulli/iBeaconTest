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
    
    @IBOutlet weak var distancLabel: UILabel!
    @IBOutlet weak var distancLabel2: UILabel!
    
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
    
    @IBOutlet weak var myPosImage: UIImageView!
    @IBAction func calculateDistance(_ sender: Any) {
    
        
    }
    
    func calculateDistance2(_ d1: Double,_ d2: Double,_ d3: Double) {
    
        let point1 = Point(position: (xCoord: 0, yCoord: 0, zCoord: nil), distance: d1)
        let point2 = Point(position: (xCoord: 0, yCoord: 9, zCoord: nil), distance: d2)
        let point3 = Point(position: (xCoord: 5, yCoord: 20, zCoord: nil), distance: d3)
        
        let myLoc = Trilaterization.trilateration(point1: point1, point2: point2, point3: point3)
        
        myPosImage.frame.origin.x = myPosImage.frame.size.width * CGFloat(myLoc[1])
        myPosImage.frame.origin.y = myPosImage.frame.size.height * CGFloat(myLoc[0])
    
    }
    
    
    func startScanning() {
        let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
        
        let beaconRegion3 = CLBeaconRegion.init(proximityUUID: uuid, identifier: "aa")
        //(proximityUUID: uuid, major: 35079, minor: 46811, identifier: "Beacon3")

        
        locationManager.startMonitoring(for: beaconRegion3)
        locationManager.startRangingBeacons(in: beaconRegion3)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons.count)
        if beacons.count > 2 {
            for beacon in beacons {
                var d1: Double = 0
                var d2: Double = 0
                var d3: Double = 0
                if beacon.major == 33119 && beacon.minor == 33895 {
                    d1 = beacon.accuracy
                } else if beacon.major == 30969 && beacon.minor == 18337 {
                    d2 = beacon.accuracy
                } else if beacon.major == 35079 && beacon.minor == 46811 {
                    d3 = beacon.accuracy
                }
                print("\(d1)/\(d2)/\(d3)")
                calculateDistance2(d1,d2,d3)
            }
        }
    }
}

