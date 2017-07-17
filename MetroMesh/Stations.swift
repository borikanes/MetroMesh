//
//  Stations.swift
//  MetroMesh
//
//  Created by Bori Oludemi on 3/28/17.
//  Copyright © 2017 Oluwabori Oludemi. All rights reserved.
//

import Foundation
import CoreLocation

struct MetroLocation {
    let latitude: Double
    let longitude: Double
}

struct MetroStation {

    let name: String
    let code: String
    var lines = [MetroLines]()
    let address: MetroLocation?
    var region: CLCircularRegion?
    var radius = 200.0 {
        didSet {
            if let addr = address {
                let addressIn2D = CLLocationCoordinate2D(
                    latitude: addr.latitude , longitude: addr.longitude)
                region = CLCircularRegion(center: addressIn2D, radius: radius, identifier: name)
                region?.notifyOnEntry = true
                region?.notifyOnExit = true
            }
        }
    }

    enum MetroLines: String {
        case redLine = "RD"
        case blueLine = "BL"
        case yellowLine = "YL"
        case orangeLine = "OR"
        case silverLine = "SV"
        case greenLine = "GR"
    }
}

extension MetroStation {
    init?(json: MasterJson.StationData) {

        guard let code = json.code, let name = json.name,
            let latitude = json.latitude, let longitude = json.longitude,
            let line1 = json.line1 else {
                debugPrint("Parsing json failed in init for MetroStations")
                return nil
        }

        let addressIn2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        self.code = code
        self.name = name
        self.address = MetroLocation(latitude: latitude, longitude: longitude)

        //Find an auto way to do the radius calculation
        region = CLCircularRegion(center: addressIn2D, radius: radius, identifier: name)
        region?.notifyOnEntry = true
        region?.notifyOnExit = true

        // At this point line1 exists because it passed the guard statement above
        self.lines.append(MetroStation.MetroLines(rawValue: line1)!)

        if let line2 = json.line2 {
            self.lines.append(MetroStation.MetroLines(rawValue: line2)!)
        }
        
        if let line3 = json.line3 {
            self.lines.append(MetroStation.MetroLines(rawValue: line3)!)
        }
        
        if let line4 = json.line4 {
            self.lines.append(MetroStation.MetroLines(rawValue: line4)!)
        }
    }
}
