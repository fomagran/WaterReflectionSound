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
    let buildingImages:[UIImage] = [#imageLiteral(resourceName: "orangeBuilding2"),#imageLiteral(resourceName: "orangeBuilding5"),#imageLiteral(resourceName: "orangeBuilding4"),#imageLiteral(resourceName: "orangeBuilding3"),#imageLiteral(resourceName: "orangeBuilding1")]
    override func awakeFromNib() {
        
        super.awakeFromNib()
       
        buildingImageView.image = buildingImages.randomElement()
        
        waterView.setGradient(color1: .systemOrange, color2: .black)
    }
}
