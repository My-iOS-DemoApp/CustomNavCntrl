//
//  ViewController.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/7/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dismissLbl: UILabel!
    
    var shouldShowDismissLbl = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.white
        
        //shadow_one()
        //hideHairLine_one()
        //shadow_Combine1()
        //hideHairLine_two()
        //shadow_Combine2()
        
        dismissLbl.isHidden = !shouldShowDismissLbl
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        //showHairLine_two()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("ViewController deinit called")
    }
    
    @IBAction func pushAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdVC
        //navigationController?.delegate = nil
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func presentAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdVC
        present(vc, animated: true, completion: nil)
        
    }
    
    private func shadow_one() {
        // WORKING Dropin shadow
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    private func hideHairLine_one() {
        // WORKING without bottom hair line imageView
        
        // should be solid color, can't use Translucent
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func shadow_Combine1() {
        hideHairLine_one()
        shadow_one()
        
    }
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
    
    private func hideHairLine_two() {
        // Remember to show it when the current view disappears.
        
        let shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        
        shadowImageView?.isHidden = true
    }
    
    private func showHairLine_two() {
        
        let shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        
        shadowImageView?.isHidden = false
    }
    
    private func shadow_Combine2() {
        hideHairLine_two()
        shadow_one()
        //self.navigationController?.navigationBar.barTintColor = UIColor.yellow
    }
    
    
    
}

