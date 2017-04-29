//
//  MMViewController.swift
//  MetroMesh
//
//  Created by Oludemi, Oluwabori (BANK) on 2/1/17.
//  Copyright © 2017 Oluwabori Oludemi. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import UserNotifications

class MMViewController: UIViewController {

    var locationManager:CLLocationManager!
    var metroStations = MMLoadStations.sharedInstance.getStations()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func currentLocationClicked(_ sender: UIButton) {
        getCurrentLocation()
    }

    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            debugPrint("Allowed to get current location")
            locationManager.startUpdatingLocation()
        } else {
            debugPrint("Whoops, you didn't enable location")
        }
    }

}

extension MMViewController: CLLocationManagerDelegate {
    /*
     *  locationManager:didUpdateLocations:
     *
     *  Discussion:
     *    Invoked when new locations are available.  Required for delivery of
     *    deferred locations.  If implemented, updates will
     *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
     *
     *    locations is an array of CLLocation objects in chronological order.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint("did update location")
        guard let location = locations.first else {
            debugPrint("Error fetching location from [CLLocation]")
            return
        }
        guard let localMetroStations = metroStations  else {
            debugPrint("Metro Stations array is empty")
            return
        }

        if (localMetroStations.first?.region?.contains(CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.latitude)))! {
            // Get information about station here THEN send notification of train statuses in that station
            _ = UNLocationNotificationTrigger(region: (localMetroStations.first?.region)!, repeats: false)
        }

        print("Lat: \(location.coordinate.latitude) --- Lon: \(location.coordinate.longitude)")
    }
}
