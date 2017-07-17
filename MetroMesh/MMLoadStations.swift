//
//  MMLoadStations.swift
//  MetroMesh
//
//  Created by Bori Oludemi on 4/27/17.
//  Copyright © 2017 Oluwabori Oludemi. All rights reserved.
//

import Foundation

class MMLoadStations {
    private init() {
        //This prevents any file from doing .... = MMLoadStations()
    }

    // dispatch_once is called behind the scenes
    static let sharedInstance = MMLoadStations()

    func getStations() -> [MetroStation]? {
        var completeStationArray = [MetroStation]()
        if let path = Bundle.main.path(forResource: "stations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let decoder = JSONDecoder()
                let masterStationArray = try decoder.decode(MasterJson.self, from: data)
                let stationArray = masterStationArray.stations
                completeStationArray = stationArray.map({MetroStation(json: $0)!})
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return completeStationArray
    }
}
