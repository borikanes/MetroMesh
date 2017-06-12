//
//  StationListViewController.swift
//  MetroMesh
//
//  Created by Bori Oludemi on 5/9/17.
//  Copyright © 2017 Oluwabori Oludemi. All rights reserved.
//

import UIKit

class StationListViewController: UIViewController {

    var metroStations = MMLoadStations.sharedInstance.getStations()
    var stationNames = [String]()
    let cellIdentifier = "stationCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableViewData()
    }

    fileprivate func setupTableViewData() {
        guard let stationNames = metroStations else {
            // swiftlint:disable todo
            // TODO: return error here
            return
        }

        self.stationNames = stationNames.map { return $0.name }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StationListViewController: UITableViewDelegate {

}

extension StationListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stationNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! StationTableViewCell
        cell.stationNameLabel.text = stationNames[indexPath.row]
        
        return cell
    }
}
