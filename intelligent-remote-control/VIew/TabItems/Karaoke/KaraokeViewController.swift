//
//  KaraokeViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class KaraokeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let v = UIView()
//        v.backgroundColor = .red
//        v.frame = view.frame
//        view.addSubview(v)
        // Do any additional setup after loading the view.
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {return}
        
        if id == "SoundPopover" {
//            segue.destination.popoverPresentationController?.delegate = self
            segue.destination.popoverPresentationController?.backgroundColor = .clear
            
            let v = UIView()
            v.frame = view.frame
            v.backgroundColor = .blue
            segue.destination.view.addSubview(v)
//            segue.destination.view.lay
            
        }
    }
}



//extension KaraokeViewController: UIPopoverPresentationControllerDelegate {
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//    }
//    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
//        return .none
//    }
//}

