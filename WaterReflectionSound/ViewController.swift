//
//  ViewController.swift
//  WaterReflectionSound
//
//  Created by Fomagran on 2021/05/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var waterCollection: UICollectionView!
    @IBOutlet weak var buildingCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == buildingCollection {
        let cell = buildingCollection.dequeueReusableCell(withReuseIdentifier: "BuildingCollectionViewCell", for: indexPath) as! BuildingCollectionViewCell
            cell.buildingImageView.image = #imageLiteral(resourceName: "building1")
            cell.configure(contentViewHeight: cell.contentView.frame.height)
        return cell
        }else {
            let cell = waterCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.contentView.setGradient(color1: .systemBlue, color2: .white)
            return cell
        }
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == buildingCollection {
            return CGSize(width: self.view.frame.size.width/3, height: 300)
        }else {
            return CGSize(width: self.view.frame.size.width/3, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}

extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
