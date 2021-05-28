//
//  ViewController.swift
//  WaterReflectionSound
//
//  Created by Fomagran on 2021/05/28.
//

import UIKit

class ViewController: UIViewController {

    let heights = [100,120,80,60,140,100,120,80,60,140,100,120,80,60,140,100,120,80,60,140,100,120,80,60,140,100,120,80,60,140,100,120,80,60,140,100,120,80,60,140,100,120,80,60,140]
    
    @IBOutlet weak var buildingCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = buildingCollection.dequeueReusableCell(withReuseIdentifier: "BuildingCollectionViewCell", for: indexPath) as! BuildingCollectionViewCell

        return cell
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: heights[indexPath.item])
    }
    
}
