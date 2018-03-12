//
//  IRCViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class IRCViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    var presenter: IRCPresentation?
    
    @IBOutlet weak var generalControlPanel: IRCGeneralControlPanel!
    @IBOutlet weak var normalControlPanel: IRCNormalControlPanel!
    @IBOutlet weak var touchControlPanel: IRCTouchControlPanel!
    @IBOutlet weak var mouseControlPanel: IRCMouseControlPanel!
    @IBOutlet weak var textControlPanel: IRCTextControlPanel!
    @IBOutlet weak var numberControlPanel: IRCNumberControlPanel!
    @IBOutlet weak var karaokeControlPanel: IRCKaraokeControlPanel!
    
    var lastMode:IRCMode.IRCType = .general
    
    lazy var numberDispatchAction:ButtonCallback = { sender in
        self.presenter?.performAction(with: SendCode.numberConvert(from: sender.tag)!)
    }
    
    lazy var deleteDispatchAction:Callback = {
        self.presenter?.performAction(with: SendCode.KEYCODE_DELETE)
    }
    
    lazy var broadcastDispatchAction:Callback = {
        //undefined
        //self.presenter?.performAction(with: SendCode.)
    }
    
    lazy var toneSwitchDispatchAction:Callback = {
        //undefined
        //self.presenter?.performAction(with: SendCode.)
    }
    
    lazy var terminateDispatchAction:Callback = {
        //undefined
        //self.presenter?.performAction(with: SendCode.)
    }
    
    lazy var recordDispatchAction:Callback = {
        //undefined
        //self.presenter?.performAction(with: SendCode.)
    }
    
    lazy var replayDispatchAction:Callback = {
        //undefined
        //self.presenter?.performAction(with: SendCode.)
    }
    
    lazy var mixerDispatchAction:Callback = {
        //undefined
        //self.presenter?.performAction(with: SendCode.)
    }
    
    lazy var insertDispatchAction:Callback = {
        //undefined
        //self.presenter?.performAction(with: SendCode.)
    }
    
    lazy var popoverAction:ButtonCallback = { sender in
        self.performSegue(withIdentifier: "IRCMode", sender: sender)
    }
    
    lazy var numAction:Callback = {
        self.numberControlPanel.isClose = false
    }
    
    lazy var karaokeAction:Callback = {
        self.karaokeControlPanel.isClose = false
    }
    
    lazy var homeAction:Callback = {
        self.presenter?.performAction(with: SendCode.KEYCODE_KOD_PLUS)
    }
    
    lazy var menuAction:Callback = {
        self.presenter?.performAction(with: SendCode.KEYCODE_MENU)
    }
    
    lazy var backAction:Callback = {
        self.presenter?.performAction(with: SendCode.KEYCODE_BACK)
    }
    
    lazy var playbackAction:Callback = {
        self.presenter?.performAction(with: SendCode.KEYCODE_MEDIA_PLAY_PAUSE)
    }
    
    lazy var powerAction:Callback = {
        self.presenter?.performAction(with: SendCode.KEYCODE_POWER)
    }
    
    lazy var volumeAction:BooleanCallback = { isIncrease in
        if isIncrease {
            self.presenter?.performAction(with: SendCode.KEYCODE_VOLUME_UP)
        } else {
            self.presenter?.performAction(with: SendCode.KEYCODE_VOLUME_DOWN)
        }
    }
    
    override func openDeviceDiscovery() {
        presenter?.presentDeviceDiscovery()
    }
    
    
    @IBAction func doAnimation(_ sender: UIButton) {
        //TODO:normal control panel's animation
        //        UIView.animate(withDuration: 0.2, animations: {
        //            self.arrowLightBackground.isHidden = false
        //            self.arrowLightBackground.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        //            self.arrowLightBackground.alpha = 0.2
        //        }) { (finished) in
        //            UIView.animate(withDuration: 1, animations: {
        //                self.arrowLightBackground.isHidden = true
        //                self.arrowLightBackground.transform = CGAffineTransform.identity
        //            })
        //        }
        
    }
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    
    lazy var modeMap:[IRCMode.IRCType:UIView] = [
        IRCMode.IRCType.general:generalControlPanel,
        IRCMode.IRCType.normal:normalControlPanel,
        IRCMode.IRCType.touch:touchControlPanel,
        IRCMode.IRCType.mouse:mouseControlPanel,
        IRCMode.IRCType.keyboard:textControlPanel,
        ]
    func changeIRCMode(mode:IRCMode.IRCType){
        modeMap.forEach(){$0.value.isHidden = true}
        modeMap[mode]?.isHidden = false
        //        switchBtn.setImage(UIImage(named: mode.darkFileName), for: .normal)
        //        switchBtn.setImage(UIImage(named: mode.lightFileName), for: .highlighted)
        switch mode {
        case .game:
            performSegue(withIdentifier: "GameMode", sender: nil)
        default:
            lastMode = mode
        }
        
        
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
        presenter?.updateConnectionStatus()
    }
    
    @objc func keyboardDidShow(_ notification: NSNotification) {
        print("Keyboard will show!")
        let keyboardSize:CGSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        print("Keyboard size: \(keyboardSize)")
        
    }
    
    @objc func keyboardDidHide(_ notification: NSNotification) {
        print("Keyboard will hide!")
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        guard let id = segue.identifier else {return}
        
        if id == "IRCMode" ,let vc = segue.destination as? IRCModePopoverViewController {
            vc.popoverPresentationController?.delegate = self
            vc.popoverPresentationController?.sourceRect = ((sender as? UIButton)?.frame)!
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
        
        setupControlPanelView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
}

extension IRCViewController: UIPopoverPresentationControllerDelegate {
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        guard let deviceType = UserDeviceType(rawValue: UIDevice.current.modelName) else {return true}
        if deviceType == .iPhoneSE {
            return false
        }
        return true
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
        presenter?.performInput(text: textView.text ?? "")
    }
}

extension IRCViewController:PositionDelegate {
    
    func shift(dx: CGFloat, dy: CGFloat) {
        presenter?.performMotion(with: Float(dx),Float(dy))
    }
    
    func tap() {
        //        coapService?.tap()
    }
    
}

extension IRCViewController: IRCView {
    func setupControlPanelView(){
        generalControlPanel.switchAction = popoverAction
        normalControlPanel.switchAction = popoverAction
        touchControlPanel.switchAction = popoverAction
        mouseControlPanel.switchAction = popoverAction
        textControlPanel.switchAction = popoverAction
        
        generalControlPanel.backAction = backAction
        normalControlPanel.backAction = backAction
        touchControlPanel.backAction = backAction
        mouseControlPanel.backAction = backAction
        textControlPanel.backAction = backAction
        
        generalControlPanel.menuAction = menuAction
        normalControlPanel.menuAction = menuAction
        touchControlPanel.menuAction = menuAction
        mouseControlPanel.menuAction = menuAction
        textControlPanel.menuAction = menuAction
        
        generalControlPanel.playbackAction = playbackAction
        generalControlPanel.numAction = numAction
        generalControlPanel.karaokeAction = karaokeAction
        
        numberControlPanel.deleteDispatchAction = deleteDispatchAction
        numberControlPanel.numberDispatchAction = numberDispatchAction
        
        karaokeControlPanel.terminateAction = terminateDispatchAction
        karaokeControlPanel.insertAction = insertDispatchAction
        karaokeControlPanel.broadcastAction = broadcastDispatchAction
        karaokeControlPanel.mixerAction = mixerDispatchAction
        karaokeControlPanel.toneSwitchAction = toneSwitchDispatchAction
        karaokeControlPanel.replayAction = replayDispatchAction
        karaokeControlPanel.recordAction = recordDispatchAction
        
        generalControlPanel.powerAction = powerAction
        normalControlPanel.powerAction = powerAction
        touchControlPanel.powerAction = powerAction
        mouseControlPanel.powerAction = powerAction
        textControlPanel.powerAction = powerAction
        
        generalControlPanel.kodAction = homeAction
        normalControlPanel.homeAction = homeAction
        touchControlPanel.homeAction = homeAction
        mouseControlPanel.homeAction = homeAction
        textControlPanel.homeAction = homeAction
        
        normalControlPanel.volumeAction = volumeAction
        touchControlPanel.volumeAction = volumeAction
        mouseControlPanel.volumeAction = volumeAction
        textControlPanel.volumeAction = volumeAction
        
        generalControlPanel.codeSender = self
        normalControlPanel.codeSender = self
        touchControlPanel.codeSender = self
        mouseControlPanel.positionDelegate = self
        textControlPanel.inputText.delegate = self
    }
    
}
extension IRCViewController:CodeSender {
    
    func dispatch(code: KeyCode) {
        
    }
    func dispatch(code: SendCode) {
        presenter?.performAction(with:code)
    }
}
