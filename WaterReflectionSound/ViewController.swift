//
//  ViewController.swift
//  WaterReflectionSound
//
//  Created by Fomagran on 2021/05/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // Configuration Settings
    private let updateInterval = 1
    private let animatioтDuration = 0.05
    private let maxPowerDelta: CGFloat = 30
    private let minScale: CGFloat = 0.9

    // Internal Timer to schedule updates from player
    private var timer: Timer?

    // Ingected Player to get power Metrics
    var player: AVAudioPlayer!

    var heights:[CGFloat] = [0]
    var time:Int = 0
    var isPlaying:Bool = false
    
    @IBOutlet weak var sunButton: GlowingButton!
    @IBOutlet weak var buildingCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSound()
       
    }
    @IBAction func tapSunButton(_ sender: Any) {
        
        if isPlaying {
            sunButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
            stop()
            sunButton.stopAnimations()
        }else {
            sunButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
            start()
            sunButton.startAnimation()
        }
        isPlaying.toggle()
    }
    
    
    func setSound() {
        guard let url = Bundle.main.url(forResource: "기다린 만큼 더", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            let duration = player.duration
            heights = Array(repeating: 0, count:Int(floor(duration + 1)) )
            player.isMeteringEnabled = true
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(updateInterval),
                                     target: self,
                                     selector: #selector(self.updateMeters),
                                     userInfo: nil,
                                     repeats: true)
    }

    func stop() {
        guard timer != nil, timer!.isValid else {
            return
        }

        timer?.invalidate()
        timer = nil
    }

    // Animate self transform depends on player meters
    @objc private func updateMeters() {
        player.updateMeters()
        let power = averagePowerFromAllChannels()
        let index = self.time
        heights[index] = 200 - floor(abs(power))*10/2
        buildingCollection.reloadItems(at: [IndexPath(item: index, section: 0)])
        if index > 10 {
            buildingCollection.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: true)
        }
        if heights.count > time {
            time += 1
        }else {
            stop()
        }
    }

    // Calculate average power from all channels
    private func averagePowerFromAllChannels() -> CGFloat {
        var power: CGFloat = 0.0
        (0..<player.numberOfChannels).forEach { (index) in
            power = power + CGFloat(player.averagePower(forChannel: index))
        }
        return power
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
