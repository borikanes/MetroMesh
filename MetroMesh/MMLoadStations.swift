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
        var stationArray = [MetroStation]()
        if let path = Bundle.main.path(forResource: "stations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                if let stations = json as? [String: [Any]] {
                    guard let stationsArray = stations["Stations"] as [Any]! else {
                        debugPrint("Could'nt find Stations key in json")
                        return nil
                    }
                    for case let each_station as [String: Any] in stationsArray {
                        guard let stationObject = MetroStation(json: each_station) else {
                            debugPrint("Seems like failable init returned nil for metroStations struct")
                            return nil
                        }
                        stationArray.append(stationObject)
                    }

                }
            } catch let error {
                print(error.localizedDescription)
            }

        }
        return stationArray
    }
}
