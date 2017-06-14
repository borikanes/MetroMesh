//
//  StationTableViewCell.swift
//  MetroMesh
//
//  Created by Bori Oludemi on 5/20/17.
//  Copyright © 2017 Oluwabori Oludemi. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet weak var stationNameLabel: UILabel!
    
    @IBOutlet weak var firstColorImage: UIImageView!
    @IBOutlet weak var secondColorImage: UIImageView!
    @IBOutlet weak var thirdColorImage: UIImageView!
    @IBOutlet weak var fourthColorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellView()
    }
    
    private func setupCellView() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
