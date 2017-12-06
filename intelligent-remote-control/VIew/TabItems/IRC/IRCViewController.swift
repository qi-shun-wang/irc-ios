//
//  IRCViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SnapKit

class IRCViewController: BaseViewController {
    
    @IBOutlet weak var bottomComponent: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var topComponent: UIView!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var powerBtn: UIButton!
    
    @IBOutlet weak var centerComponent: UIView!
    @IBOutlet weak var arrowBtn: UICircularButton!
    @IBOutlet weak var arrowLightBackground: UIImageView!
    @IBOutlet weak var touchPad: UITouchPadView!
    @IBOutlet weak var mousePad: UIMousePadView!
    
    @IBAction func doAnimation(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.arrowLightBackground.isHidden = false
            self.arrowLightBackground.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.arrowLightBackground.alpha = 0.2
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.arrowLightBackground.isHidden = true
                self.arrowLightBackground.transform = CGAffineTransform.identity
            })
        }
        
    }
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    
    func changeIRCMode(mode:IRCMode.IRCType){
        switch mode {
        case .normal:
            arrowBtn.isHidden = false
            touchPad.isHidden = true
            mousePad.isHidden = true
            
        case .touch:
            arrowBtn.isHidden = true
            touchPad.isHidden = false
            mousePad.isHidden = true
        case .mouse:
            arrowBtn.isHidden = true
            touchPad.isHidden = true
            mousePad.isHidden = false
        default:
            break
        }
    }
    
    func setupNormalModeLayout(component:UIView){
        let length = min(component.bounds.width, component.bounds.height)
        
        arrowBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.centerX.equalTo(component.snp.centerX)
        }
        arrowLightBackground.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.centerX.equalTo(component.snp.centerX)
        }
    }
    func setupTouchModeLayout(component:UIView,mode:IRCMode = IRCMode(type: .touch)){
        let length = min(component.bounds.width, component.bounds.height) - 16
        
        touchPad.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.centerX.equalTo(component.snp.centerX)
        }
        touchPad.setTitle(with: mode.name)
        
    }
    func setupMouseModeLayout(component:UIView,mode:IRCMode = IRCMode(type: .mouse)){
        let length = min(component.bounds.width, component.bounds.height) - 16
        mousePad.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.centerX.equalTo(component.snp.centerX)
        }
        mousePad.setTitle(with: mode.name)
    }
    func setupCenterBtnLayout(component:UIView,mode:IRCMode = IRCMode(type: .normal))  {
        setupNormalModeLayout(component:component)
        setupTouchModeLayout(component:component)
        setupMouseModeLayout(component:component)
        component.bringSubview(toFront: arrowBtn)
    }
    
    func setupBottomBtnsLayout(component:UIView) {
        let length = 60
        backBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.leading.equalTo(component.snp.leading).offset(8)
        }
        
        menuBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.trailing.equalTo(component.snp.trailing).offset(-8)
        }
        
        homeBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.centerX.equalTo(component.snp.centerX)
        }
    }
    func setupTopBtnsLayout(component:UIView){
        let length = 60
        switchBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.leading.equalTo(component.snp.leading).offset(8)
        }
        
        powerBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.trailing.equalTo(component.snp.trailing).offset(-8)
        }
        
        minusBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.trailing.equalTo(component.snp.centerX).offset(-8)
        }
        
        plusBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.leading.equalTo(component.snp.centerX).offset(8)
        }
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        viewModel?.openMenu()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTopBtnsLayout(component:topComponent)
        setupBottomBtnsLayout(component: bottomComponent)
        setupCenterBtnLayout(component: centerComponent)
    }
    
    override func viewDidLoad() {
        viewModel = IRCViewModel(view: self)
        super.viewDidLoad()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            
        }) { (context) in
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "IRCMode" ,let vc = segue.destination as? IRCModePopoverViewController {
            vc.popoverPresentationController?.delegate = self
            vc.popoverPresentationController?.sourceRect = (switchBtn?.bounds)!
            vc.delegate = self
        }
    }
}


extension IRCViewController:IRCViewControllerProtocol{
    
}

extension IRCViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension IRCViewController:IRCModePopoverViewControllerDelegate{
    func didSelect(mode: IRCMode) {
        print(mode)
        changeIRCMode(mode: mode.type)
    }
}
