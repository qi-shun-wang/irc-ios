//
//  IRCViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class IRCViewController: BaseViewController2, StoryboardLoadable {
    
    // MARK: Properties
    
    var presenter: IRCPresentation?
    
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
    @IBOutlet weak var keyboardInput: UITextView!
    
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
    var lastMode:IRCMode.IRCType = .normal
    
    func changeIRCMode(mode:IRCMode.IRCType){
        switchBtn.setImage(UIImage(named: mode.darkFileName), for: .normal)
        switchBtn.setImage(UIImage(named: mode.lightFileName), for: .highlighted)
        switch mode {
        case .normal:
            arrowBtn.isHidden = false
            touchPad.isHidden = true
            mousePad.isHidden = true
            keyboardInput.isHidden = true
            lastMode = mode
        case .touch:
            arrowBtn.isHidden = true
            touchPad.isHidden = false
            mousePad.isHidden = true
            keyboardInput.isHidden = true
            lastMode = mode
        case .mouse:
            arrowBtn.isHidden = true
            touchPad.isHidden = true
            mousePad.isHidden = false
            keyboardInput.isHidden = true
            lastMode = mode
        case .keyboard:
            arrowBtn.isHidden = true
            touchPad.isHidden = true
            mousePad.isHidden = true
            keyboardInput.isHidden = false
            lastMode = mode
        case .game:
            performSegue(withIdentifier: "GameMode", sender: nil)
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
    func setupKeyboardModeLayout(component:UIView){
        let length = min(component.bounds.width, component.bounds.height) - 16
        keyboardInput.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.centerX.equalTo(component.snp.centerX)
        }
    }
    func setupKeyboardModeLayout(component:UIView,with height:CGFloat){
        let length = min(component.bounds.width, component.bounds.height) - 16
        keyboardInput.snp.remakeConstraints { (make) in
            make.top.equalTo(component.snp.top)
            make.height.equalTo(height)
            make.width.equalTo(length)
            make.centerX.equalTo(component.snp.centerX)
        }
        
    }
    func setupCenterBtnLayout(component:UIView,mode:IRCMode = IRCMode(type: .normal))  {
        setupNormalModeLayout(component:component)
        setupTouchModeLayout(component:component)
        setupMouseModeLayout(component:component)
        setupKeyboardModeLayout(component:component)
        component.bringSubview(toFront: arrowBtn)
    }
    
    func setupBottomBtnsLayout(component:UIView) {
        let length = min(80,component.bounds.width/3)
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
        let padding:CGFloat = 8
        let length = min(80,component.bounds.width/4 - 2*padding)
        switchBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.leading.equalTo(component.snp.leading).offset(padding)
        }
        
        powerBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.trailing.equalTo(component.snp.trailing).offset(-padding)
        }
        
        minusBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.trailing.equalTo(component.snp.centerX).offset(-padding)
        }
        
        plusBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(component.snp.centerY)
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.leading.equalTo(component.snp.centerX).offset(padding)
        }
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        //        viewModel?.openMenu()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupTopBtnsLayout(component:topComponent)
        setupBottomBtnsLayout(component: bottomComponent)
        setupCenterBtnLayout(component: centerComponent)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(_:)), name: .UIKeyboardDidShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: .UIKeyboardDidHide , object: nil)
        let value =  UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    @objc func keyboardDidShow(_ notification: NSNotification) {
        print("Keyboard will show!")
        let keyboardSize:CGSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        print("Keyboard size: \(keyboardSize)")
        
        let cH = UIScreen.main.bounds.height - keyboardSize.height - 90 - centerComponent.frame.minY
        setupKeyboardModeLayout(component: centerComponent,with:cH)
    }
    
    @objc func keyboardDidHide(_ notification: NSNotification) {
        print("Keyboard will hide!")
        
        setupKeyboardModeLayout(component: centerComponent)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        guard let id = segue.identifier else {return}
        
        if id == "IRCMode" ,let vc = segue.destination as? IRCModePopoverViewController {
            vc.popoverPresentationController?.delegate = self
            vc.popoverPresentationController?.sourceRect = (switchBtn?.bounds)!
            vc.delegate = self
            
        } else if id == "GameMode", let nc = segue.destination as? UINavigationController ,let vc =  nc.viewControllers.first as? IRCGameModeViewController {
            vc.popoverPresentationController?.delegate = self
            vc.delegate = self
        }
        
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
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

extension IRCViewController:IRCGameModeViewControllerDelegate{
    
    func didExit() {
        changeIRCMode(mode: lastMode)
        
    }
}

extension IRCViewController:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print(textView.text)
        //        textView.text = ""
    }
}

extension IRCViewController: IRCView {
    // TODO: implement view output methods
//    func setupNavigationLeftItem(image named: String, title text: String) {
//        let button = UIButton()
//        button.setImage(UIImage(named: named), for: .normal)
//        button.setTitle(text, for: .normal)
//        button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
//        button.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
//    }
//    
//    func setupNavigationRightItem(image named: String, title text: String) {
//        let buttonR = UIButton()
//        buttonR.sizeToFit()
//        buttonR.setImage(UIImage(named: named), for: .normal)
//        buttonR.addTarget(self, action: #selector(openQRScanner), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonR)
//    }
}
