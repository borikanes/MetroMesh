//
//  MMJsonModel.swift
//  MetroMesh
//
//  Created by Bori Oludemi on 6/27/17.
//  Copyright © 2017 Oluwabori Oludemi. All rights reserved.
//

import Foundation

struct MasterJson: Decodable {
    var stations: [StationData]
    
    struct StationData: Decodable {
        var name: String?
        var code: String?
        var line1: String?
        var line2: String?
        var line3: String?
        var line4: String?
        var latitude: Double?
        var longitude: Double?
        var stationTogether1: String
        var stationTogether2: String
        var address: Address

        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case code = "Code"
            case line1 = "LineCode1"
            case line2 = "LineCode2"
            case line3 = "LineCode3"
            case line4 = "LineCode4"
            case latitude = "Lat"
            case longitude = "Lon"
            case stationTogether1 = "StationTogether1"
            case stationTogether2 = "StationTogether2"
            case address = "Address"
        }

        struct Address: Decodable {
            var street: String
            var city: String
            var state: String
            var zip: String

            enum CodingKeys: String, CodingKey {
                case street = "Street"
                case city = "City"
                case state = "State"
                case zip = "Zip"
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case stations = "Stations"
    }
}

struct Station {
    var name: String?
    var code: String?
    var line1: String?
    var line2: String?
    var line3: String?
    var line4: String?
    var latitude: Double?
    var longitude: Double?
}

extension Station {
    init(from master: MasterJson.StationData) {
        name = master.name
        code = master.code
        line1 = master.line1
        line2 = master.line2
        line3 = master.line3
        line4 = master.line4
        latitude = master.latitude
        longitude = master.longitude
    }
}
