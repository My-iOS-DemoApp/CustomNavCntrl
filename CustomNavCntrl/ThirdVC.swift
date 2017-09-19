//
//  ThirdVC.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/21/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class ThirdVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    deinit {
        print("ThirdVC deinit called")
    }

}
