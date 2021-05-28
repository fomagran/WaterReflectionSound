//
//  BuildingCollectionViewCell.swift
//  WaterReflectionSound
//
//  Created by Fomagran on 2021/05/28.
//

import UIKit

class BuildingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var buildingImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buildingImageView.image = #imageLiteral(resourceName: "building1")
        waterView.setGradient(color1: .systemBlue, color2: .white)
    }
}
