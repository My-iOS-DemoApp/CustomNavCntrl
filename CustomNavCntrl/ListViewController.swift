//
//  ListViewController.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/16/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//


enum TransitionType:String {
    case appleNews = "Apple News Transition"
    case circleNav = "Circle Nav Transition"
    case circleModal = "Circle Modal Transition"
    case zoomModal = "Zoom Modal Transition"
    case buttonAnim = "Button Anim & Transition"
}

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let reuseIdentifier = "myFuckingCell"
    let data = [TransitionType.appleNews, TransitionType.circleNav, TransitionType.circleModal, TransitionType.zoomModal, TransitionType.buttonAnim]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) 
        cell.textLabel?.text = data[indexPath.section].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == (data.count-1) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "LoginButton", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginButtonVC") as! LoginButtonVC
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            vc.transitionType = data[indexPath.section]
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }

}
