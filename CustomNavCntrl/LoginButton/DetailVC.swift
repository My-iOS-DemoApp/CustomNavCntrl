//
//  DetailVC.swift
//  ButtonAnimation
//
//  Created by Shuvo on 8/21/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var dismissLbl: UILabel!
    var shouldShowDismissLbl = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //dismissLbl.isHidden = !shouldShowDismissLbl
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

}
