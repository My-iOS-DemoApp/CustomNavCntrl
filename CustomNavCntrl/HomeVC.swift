//
//  HomeVC.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/13/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak private var nextBtn: UIButton!
    
    var transitionType:TransitionType = .appleNews
    
    private let circleTransitionNavDelegate = CircleTransitionNavDelegate()
    private let circleTransitionDelegate = CircleTransitonDelegate()
    //private let thumbTransitionNavDelegate = ThumbZoomTransitionNavDelegate()
    private let zoomTransitionNavDelegate = ZoomTransitionNavDelegate()
    private let zoomTransitionDelegate = ZoomTransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if transitionType == .circleModal {
            nextBtn.layer.cornerRadius = nextBtn.frame.width/2
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = transitionType.rawValue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        title = ""
    }
    
    deinit {
        print("HomeVC deinit called")
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        switch transitionType {
        case .appleNews:
            // thumbnail zoom push
            //thumbTransitionNavDelegate.originView = sender
            zoomTransitionNavDelegate.originView = sender
            navigationController?.delegate = zoomTransitionNavDelegate
            //thumbTransitionNavDelegate
            navigationController?.pushViewController(vc, animated: true)
            break
        case .circleNav:
            // circle push
            circleTransitionNavDelegate.originView = sender
            navigationController?.delegate = circleTransitionNavDelegate
            navigationController?.pushViewController(vc, animated: true)
            break
        case .circleModal:
            // circle modal present
            circleTransitionDelegate.originView = sender
            vc.transitioningDelegate = circleTransitionDelegate
            vc.shouldShowDismissLbl = true
            present(vc, animated: true, completion: nil)
            break
        case .zoomModal:
            // zoom modal present
            zoomTransitionDelegate.originView = sender
            vc.transitioningDelegate = zoomTransitionDelegate
            //vc.modalPresentationStyle = .fullScreen
            vc.shouldShowDismissLbl = true
            present(vc, animated: true, completion: nil)
            break
        default:
            break
        }
        
    }

}
