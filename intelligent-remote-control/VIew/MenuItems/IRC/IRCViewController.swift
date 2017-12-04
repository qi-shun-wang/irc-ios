//
//  IRCViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class IRCViewController: BaseViewController {
    
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var modeContainer: UIView!
    @IBOutlet weak var powerContainer: UIView!
    @IBOutlet weak var operationContainer: UIView!
    @IBAction func toggleMenu(_ sender: UIButton) {
        viewModel?.openMenu()
    }
    
    @IBOutlet weak var powerBtn: UIButton!
    @IBAction func powerAction(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        viewModel = IRCViewModel(view: self)
        super.viewDidLoad()
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            
        }) { (context) in
            (self.viewModel as! IRCViewModel).renderPowerContainer()
        }
    }
    

}


extension IRCViewController:IRCViewControllerProtocol{
    func setupContainer() {
//        let maxW = container.frame.width - 8
//        let maxH = container.frame.height - 8
//
//        let upperContainerH = maxH*0.2
//        let lowerContainerH = maxH*0.8
//
//        let leftContainerW = maxW*0.7
//        let rightContainerW = maxW*0.3
//
//        let modeContainerSize = CGSize(width: leftContainerW, height: upperContainerH)
//        let modeContainerPoint = CGPoint.zero
//        let modeContainerFrame = CGRect(origin:modeContainerPoint, size: modeContainerSize)
//
//        let powerContainerSize = CGSize(width: rightContainerW, height: upperContainerH)
//        let powerContainerPoint = CGPoint(x: leftContainerW, y: 0)
//        let powerContainerFrame = CGRect(origin:powerContainerPoint, size: powerContainerSize)
//
//        let operationContainerSize = CGSize(width: maxW, height: lowerContainerH)
//        let operationContainerPoint = CGPoint(x: 0, y: upperContainerH)
//        let operationContainerFrame = CGRect(origin:operationContainerPoint, size: operationContainerSize)
//
//        modeContainer.frame = modeContainerFrame
//        powerContainer.frame = powerContainerFrame
//        operationContainer.frame = operationContainerFrame
    }
    func setupModeContainer() {
        
    }
    func setupPowerContainer() {
//        let maxW = powerContainer.frame.width
//        let maxH = powerContainer.frame.height
//        let powerW = min(maxW, maxH)
//
//
//        let powerBtnSize = CGSize(width: powerW, height: powerW)
//        let powerBtnPoint = CGPoint.zero
//        let powerBtnBouns = CGRect(origin:powerBtnPoint, size: powerBtnSize)
//
//        powerBtn.bounds = powerBtnBouns
//
//        powerBtn.centerXAnchor.constraint(equalTo: powerContainer.centerXAnchor).isActive = true
//
    }
    func setupOperationContainer() {
        
    }
}
