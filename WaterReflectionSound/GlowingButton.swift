//
//  GlowingButton.swift
//  WaterReflectionSound
//
//  Created by Fomagran on 2021/05/29.
//

import UIKit

@IBDesignable
class GlowingButton: UIButton {

    @IBInspectable var animDuration : CGFloat = 3
    @IBInspectable var cornerRadius : CGFloat = 5
    @IBInspectable var maxGlowSize : CGFloat = 10
    @IBInspectable var minGlowSize : CGFloat = 0
    @IBInspectable var glowColor : UIColor = nil ?? UIColor.red
    @IBInspectable var animateAlways : Bool = false
    fileprivate var animating : Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentScaleFactor = UIScreen.main.scale
        self.layer.masksToBounds = false

        if(self.animateAlways){
            self.setupButtonForContinueAnimation()
            self.startAnimation()
        }else{
            self.setupButton()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if(!self.animateAlways){
            let layerAnimation = CABasicAnimation(keyPath: "shadowRadius")
            layerAnimation.fromValue = minGlowSize
            layerAnimation.toValue = maxGlowSize
            layerAnimation.isAdditive = false
            layerAnimation.duration = CFTimeInterval(animDuration/2)
            layerAnimation.fillMode = CAMediaTimingFillMode.forwards
            layerAnimation.isRemovedOnCompletion = false
            self.layer.add(layerAnimation, forKey: "addGlowing")
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if(!self.animateAlways){
            let layerAnimation = CABasicAnimation(keyPath: "shadowRadius")
            layerAnimation.fromValue = maxGlowSize
            layerAnimation.toValue = minGlowSize
            layerAnimation.isAdditive = false
            layerAnimation.duration = CFTimeInterval(animDuration/2)
            layerAnimation.fillMode = CAMediaTimingFillMode.forwards
            layerAnimation.isRemovedOnCompletion = false
            self.layer.add(layerAnimation, forKey: "removeGlowing")
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

        if(!self.animateAlways){
            let layerAnimation = CABasicAnimation(keyPath: "shadowRadius")
            layerAnimation.fromValue = maxGlowSize
            layerAnimation.toValue = minGlowSize
            layerAnimation.isAdditive = false
            layerAnimation.duration = CFTimeInterval(animDuration/2)
            layerAnimation.fillMode = CAMediaTimingFillMode.forwards
            layerAnimation.isRemovedOnCompletion = false
            self.layer.add(layerAnimation, forKey: "removeGlowing")
        }
    }

    func setupButton()
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowPath = CGPath(roundedRect: self.bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
        self.layer.shadowRadius = 0
        self.layer.shadowColor = self.glowColor.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 1
    }

    func setupButtonForContinueAnimation()
    {
        self.setupButton()
        self.layer.shadowRadius = maxGlowSize
    }

    func startAnimation()
    {
        let layerAnimation = CABasicAnimation(keyPath: "shadowRadius")
        layerAnimation.fromValue = maxGlowSize
        layerAnimation.toValue = minGlowSize
        layerAnimation.autoreverses = true
        layerAnimation.isAdditive = false
        layerAnimation.duration = CFTimeInterval(animDuration/2)
        layerAnimation.fillMode = CAMediaTimingFillMode.forwards
        layerAnimation.isRemovedOnCompletion = false
        layerAnimation.repeatCount = .infinity
        self.layer.add(layerAnimation, forKey: "glowingAnimation")

    }

    func stopAnimations() {
        self.layer.removeAllAnimations()
    }

}
