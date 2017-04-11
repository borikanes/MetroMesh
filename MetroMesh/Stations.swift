//
//  Stations.swift
//  MetroMesh
//
//  Created by Bori Oludemi on 3/28/17.
//  Copyright © 2017 Oluwabori Oludemi. All rights reserved.
//

import Foundation

struct MetroStations {

    enum MetroLines: String {
        case redColor = "RD"
        case blue = "BL"
        case yellow = "YL"
        case orange = "OR"
        case silver = "SV"
        case green = "GR"
    }

    struct MetroLocation {
        let latitude: Double
        let longitude: Double
    }

    let name: String
    let code: String
    var lines = [MetroLines]()
    let address: MetroLocation

    init?(json: [String: Any]) {
        guard let code = json["Code"] as? String,
            let name = json["Name"] as? String,
            let latitude = json["Lat"] as? Double,
            let longitude = json["Lon"] as? Double,
            let lineCode1 = json["LineCode1"] as? String? else {
                debugPrint("Parsing json failed in init for MetroStations")
                return nil
        }
        self.code = code
        self.name = name
        self.address = MetroLocation(latitude: latitude, longitude: longitude)
        if let line1 = lineCode1 { // This will always have a value or would it 🤔
            self.lines.append(MetroStations.MetroLines(rawValue: line1)!)
        }

        if let line2 = json["LineCode2"] as? String? {
            if let line2 = line2 {
                self.lines.append(MetroStations.MetroLines(rawValue: line2)!)
            }
        }

        if let line3 = json["LineCode3"] as? String? {
            if let line3 = line3 {
                self.lines.append(MetroStations.MetroLines(rawValue: line3)!)
            }
        }

        if let line4 = json["LineCode4"] as? String? {
            if let line4 = line4 {
                self.lines.append(MetroStations.MetroLines(rawValue: line4)!)
            }
        }
    }

}
