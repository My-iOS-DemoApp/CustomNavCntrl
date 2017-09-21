//
//  LoadingButton.swift
//  ButtonAnimation
//
//  Created by Shuvo on 8/16/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class LoadingButton: UIButton {
    
    private var cachedTitle: String?
    private var cachedConerRadius: CGFloat = 0
    
    //Don't work in swift 4
//    lazy private var spiner: CircleLayer! = {
//        let cLayer = CircleLayer(frame: self.frame)
//        self.layer.addSublayer(cLayer)
//        return cLayer
//    }()
    
    private var spiner:CircleLayer {
        get {
            if(_spiner == nil) {
                _spiner = CircleLayer(frame: self.frame)
                self.layer.addSublayer(_spiner!)
            }
            return _spiner!
        }
    }
    
    private var _spiner:CircleLayer?
    
    @IBInspectable open var spinnerColor: UIColor = UIColor.white {
        didSet {
            spiner.circleColor = spinnerColor
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    //MARK:- Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required public init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonSetup()
    }
    
    
    //MARK:- Private Methods
    private func commonSetup() {
        spiner.circleColor = spinnerColor
        layer.cornerRadius = cornerRadius
    }
    
    func startAnimation() {
        
        resetSpinnerIfNeeded()
        
        cachedTitle = title(for: UIControlState())
        cachedConerRadius = layer.cornerRadius
        setTitle("", for: UIControlState())
        
        UIView.animate(withDuration: 0.1, animations: { [unowned self] in
            self.layer.cornerRadius = self.frame.height / 2
            }, completion: { [unowned self] (finished) in
                self.shrink()
                Timer.schedule(delay: 0.1) { timer in
                    self.spiner.animation()
                }
        })
    }
    
    func stopAnimation() {
        self.spiner.stopAnimation()
        layer.removeAllAnimations()
        layer.cornerRadius = cachedConerRadius
        setTitle(self.cachedTitle, for: UIControlState())
    }
    
    private func shrink() {
        let shrinkAnim = SMAnimation.shrink(from: frame.width, to: frame.height)
        layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)
    }
    
    private func resetSpinnerIfNeeded() {
        if spiner.frame != self.frame {
            _spiner = nil
            commonSetup()
        }
    }
    
}
