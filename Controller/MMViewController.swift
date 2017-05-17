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

    var locationManager = CLLocationManager()
    let center = UNUserNotificationCenter.current()

    var metroStations = MMLoadStations.sharedInstance.getStations()
    var regionsArray: [CLRegion]?

    override func viewDidLoad() {
        super.viewDidLoad()

        regionsArray = getRegions()
    }

    @IBAction func currentLocationClicked(_ sender: UIButton) {
        getCurrentLocation()
    }

    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true

        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            guard let regionArray = regionsArray else {
                return
            }

            // Starts monitoring each region in the regions array by using the helper function and map
            // It's set to nothing because i don't need the return array from map
            _ = regionArray.map { startMonitoringHelper(region: $0) }

        }

        if CLLocationManager.locationServicesEnabled() {
            debugPrint("Allowed to get current location")
            locationManager.startUpdatingLocation()
        } else {
            debugPrint("Whoops, you didn't enable location")
        }
    }

    func startMonitoringHelper(region: CLRegion) {
        locationManager.startMonitoring(for: region)
    }

    func getRegions() -> [CLRegion]? {
        guard let metro_stations = metroStations else {
            return nil
        }

        let regionsArray = metro_stations.map {
            return $0.region!
        }

        return regionsArray
    }

    // MARK: Helper fuction to send region notifications
    func sendLocalNotification(region: CLRegion) {
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = "Hurry up!"
                content.body = "You train leaves in 2 minutes"
                content.sound = UNNotificationSound.default()

                //Get information about station here THEN send notification of train statuses in that station
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1,
                                                                repeats: false)
                let identifier = region.identifier
                let request = UNNotificationRequest(identifier: identifier,
                                                    content: content, trigger: trigger)
                self.center.add(request, withCompletionHandler: { (error) in
                    if let error = error {
                        // Something went wrong
                        debugPrint(error)
                    }
                })
            } else {
                // swiftlint:disable todo
                // TODO: Handle error when alerts are not shown
            }
        }
    }

}

/**
 CLLocation delegate methods
 */
// MARK: CLLocationManagerDelegate extension
extension MMViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint("did update location")
        guard let location = locations.first else {
            debugPrint("Error fetching location from [CLLocation]")
            return
        }

        print("Lat: \(location.coordinate.latitude) --- Lon: \(location.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else if status == .denied || status == .restricted || status == .notDetermined {
            // TODO: Display message to user showing that they need to enable location
        }
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        sendLocalNotification(region: region)
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error occured in didFailWithError with: \(error)")
    }

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?,
                         withError error: Error) {
        debugPrint("Monitoring did fail for region with \(error)")
    }
}
