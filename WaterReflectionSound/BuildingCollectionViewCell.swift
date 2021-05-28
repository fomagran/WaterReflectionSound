//
//  BuildingCollectionViewCell.swift
//  WaterReflectionSound
//
//  Created by Fomagran on 2021/05/28.
//

import UIKit

class BuildingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var buildingImageView:UIImageView!
    
    func configure(contentViewHeight:CGFloat) {
        imageViewHeight.constant = 200
    }
    
}
