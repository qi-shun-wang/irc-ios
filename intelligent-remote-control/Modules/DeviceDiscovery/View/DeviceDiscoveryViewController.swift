//
//  DeviceDiscoveryViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/30.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class DeviceDiscoveryViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    var presenter: DeviceDiscoveryPresentation?
    @IBOutlet weak var connectionMessage: UILabel!
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var animateDeviceImage: UIImageView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var lineImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var failureBlur: UIVisualEffectView!
    @IBOutlet weak var failureImage: UIImageView!
    @IBOutlet weak var failureMessage: UILabel!
    @IBOutlet weak var help: UIButton!
    @IBOutlet weak var search: UIButton!
    
    @IBAction func dismissAction(_ sender: UIButton) {
        presenter?.dissmiss()
    }
    @IBAction func research(_ sender: UIButton) {
        presenter?.research()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        let pink = UIColor(red:243/255.0, green:58/255.0, blue:162/255.0, alpha: 1)
        let purple = UIColor(red:175/255.0, green:35/255.0, blue:238/255.0, alpha: 1)
         view.applyGradient(colours: [pink,purple], locations: [0.0,1.0])
    }
}


extension DeviceDiscoveryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let frame = collectionView.convert((collectionView.cellForItem(at: indexPath)?.frame)!, to: collectionView.superview)
        
        
        let x = Float(frame.origin.x)
        let y = Float(frame.origin.y)
        let w = Float(frame.width)
        let h = Float(frame.height)
        
        presenter?.setStartAnimation(at:x,y,with:w,h)
        presenter?.didSelectItem(at: indexPath)
    }
    
}

extension DeviceDiscoveryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter!.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let info = presenter?.cellForItem(at: indexPath)
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "DeviceDiscoveryCollectionViewCell", for: indexPath) as! DeviceDiscoveryCollectionViewCell
        item.deviceIcon.image = UIImage(named:info?.deviceIconName ?? "")
        item.deviceTitle.text = info?.deviceTitle
        return item
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var fingers:[UIImage] = []
        for i in 1...4 {
            fingers.append(UIImage(named:"finger\(i)")!)
        }
        var rings:[UIImage] = []
        for i in 1...10 {
            rings.append(UIImage(named:"ring\(i)")!)
        
        }
        (cell as! DeviceDiscoveryCollectionViewCell).ring.animationImages = rings
        (cell as! DeviceDiscoveryCollectionViewCell).ring.animationDuration = 2
        (cell as! DeviceDiscoveryCollectionViewCell).ring.startAnimating()
        (cell as! DeviceDiscoveryCollectionViewCell).finger.animationImages = fingers
        (cell as! DeviceDiscoveryCollectionViewCell).finger.animationDuration = 0.5
        (cell as! DeviceDiscoveryCollectionViewCell).finger.startAnimating()
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! DeviceDiscoveryCollectionViewCell).finger.stopAnimating()
        (cell as! DeviceDiscoveryCollectionViewCell).ring.stopAnimating()
    }
}

extension DeviceDiscoveryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // flow layout have all the important info like spacing, inset of collection view cell, fetch it to find out the attributes specified in xib file
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        // subtract section left/ right insets mentioned in xib view
        
        let widthAvailbleForAllItems =  (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)
        
        // Suppose we have to create nColunmns
        // widthForOneItem achieved by sunbtracting item spacing if any
        let nColumns:CGFloat = 2.5
        let widthForOneItem = widthAvailbleForAllItems/nColumns - flowLayout.minimumInteritemSpacing
        
        
        // here height is mentioned in xib file or storyboard
        return CGSize(width: CGFloat(widthForOneItem), height:flowLayout.itemSize.height)
        //        return CGSize(width: CGFloat(widthForOneItem), height:(flowLayout.itemSize.height))
        
    }
}


extension DeviceDiscoveryViewController: DeviceDiscoveryView {
    
    // TODO: implement view output methods
    func showConnectedFailure(with text:String) {
        failureBlur.isHidden = false
        failureMessage.text = text
        failureImage.image = UIImage(named:"wifi_not_connected")
    }
    func stopConnectionAnimating() {
        lineImage.isHidden = true
        failureBlur.isHidden = true
        lineImage.stopAnimating()
    }
    func showConnectedSuccess(){
        blur.isHidden = false
        failureBlur.isHidden = true
    }
    func showDeviceNotFound(with text:String) {
        failureBlur.isHidden = false
        failureMessage.text = text
        failureImage.image = UIImage(named:"device_not_found")
    }
    func stopSearchAnimating() {
        phoneImage.stopAnimating()
    }
    
    func startConnectionAnimating(){
        lineImage.isHidden = false
        failureBlur.isHidden = true
        lineImage.startAnimating()
    }
    
    func startSearchAnimating(){
        blur.isHidden = true
        failureBlur.isHidden = true
        phoneImage.startAnimating()
    }
    
    func setupAnimationImages(){
        var phoneImages:[UIImage] = []
        var lineImages:[UIImage] = []
        var kodImages:[UIImage] = []
        for i in 1...96 {phoneImages.append( UIImage(named:"scan\(i)")!)}
        for i in 1...29 {lineImages.append( UIImage(named:"line\(i)")!)}
        for i in 1...39 {kodImages.append( UIImage(named:"kod_white\(i)")!)}
        
        phoneImage.animationImages = phoneImages
        lineImage.animationImages = lineImages
        animateDeviceImage.animationImages = kodImages
        
        phoneImage.animationDuration = 3
        lineImage.animationDuration = 1
        lineImage.isHidden = true
        
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func startAnimation(at x: Float, _ y: Float, with w: Float, _ h: Float) {
        collectionView.isHidden = true
        let x = CGFloat(x)
        let y = CGFloat(y)
        let w = CGFloat(w)
        let h = CGFloat(h)
        animateDeviceImage.frame = CGRect(x: x, y: y, width: w, height: h)
        animateDeviceImage.isHidden = false
        
        UIView.animate(withDuration: 1, animations: {
            self.animateDeviceImage.center.x = self.lineImage.center.x
            self.animateDeviceImage.center.y = self.lineImage.center.y - self.lineImage.bounds.height/4
            self.animateDeviceImage.bounds.size = CGSize(width: self.view.bounds.width*0.7, height: self.view.bounds.width*0.7)
        }) { (isDone) in
            self.presenter?.startConnection()
            self.deviceName.center.x = self.animateDeviceImage.center.x
            self.deviceName.center.y = self.animateDeviceImage.center.y + self.view.bounds.width*0.7/2
            self.deviceName.bounds.size = CGSize(width: self.view.bounds.width, height: 60)
            self.connectionMessage.center.x = self.animateDeviceImage.center.x
            self.connectionMessage.center.y = self.deviceName.center.y + 60
            self.connectionMessage.bounds.size = CGSize(width: self.view.bounds.width, height: 60)
            self.animateDeviceImage.startAnimating()
            
        }
        
    }
    
    func setupSelectedDeviceName(text:String){
        deviceName.text = text
    }
    
    func setupConnectionMessage(text:String){
        connectionMessage.text = text
    }
    
    func setupHeaderTitle(text:String){
        headerTitle.text = text
    }
}
