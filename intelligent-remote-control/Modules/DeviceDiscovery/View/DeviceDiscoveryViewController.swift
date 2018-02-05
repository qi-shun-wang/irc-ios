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
    @IBOutlet weak var bg: UIImageView!
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
    }
    
    func add(size:CGSize)->UIImage?{
        let t = UIImage(named:"light")
        let b = bg.image
        
        UIGraphicsBeginImageContext( bg.frame.size)
        // Use existing opacity as is
        b?.draw(in:bg.bounds )
        // Apply supplied opacity
        t?.draw(in: bg.bounds, blendMode: .screen, alpha: 1)
        let result =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    func addRainbow(to img: UIImage) -> UIImage {
        
        
        // set up the colors – these are based on my trial and error
        let red = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 0.8)
        let orange = UIColor(red: 1, green: 0.7, blue: 0.35, alpha: 0.8)
        let yellow = UIColor(red: 1, green: 0.85, blue: 0.1, alpha: 0.65)
        let green = UIColor(red: 0, green: 0.7, blue: 0.2, alpha: 0.5)
        let blue = UIColor(red: 0, green: 0.35, blue: 0.7, alpha: 0.5)
        let purple = UIColor(red: 0.3, green: 0, blue: 0.5, alpha: 0.6)
        let black = UIColor.black
        let white = UIColor.white
        let colors = [
            white,
            //                        red,
            //                        orange,
            //                        yellow,
            //                        green,
            //                        blue,
            //                        purple,
            //                        black
        ]
        
        // create a CGRect representing the full size of our input iamge
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        
        // figure out the height of one section (there are six)
        let sectionHeight = img.size.height/CGFloat(colors.count)
        
        
        let renderer = UIGraphicsImageRenderer(size: img.size)
        
        let result = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(rect)
            
            // loop through all six colors
            for i in 0 ..< colors.count {
                let color = colors[i]
                
                // figure out the rect for this section
                let rect = CGRect(x: 0, y: CGFloat(i) * sectionHeight, width: rect.width, height: sectionHeight)
                
                // draw it onto the context at the right place
                color.set()
                ctx.fill(rect)
            }
            
            // now draw our input image over using Luminosity mode, with a little bit of alpha to make it fainter
            img.draw(in: rect, blendMode: .screen, alpha: 1)
        }
        
        return result
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
        for i in 1...3 {
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
    func stopConnectionAnimating() {
        lineImage.isHidden = true
        lineImage.stopAnimating()
    }
    func showConnectedSuccess(){
        blur.isHidden = false
        failureBlur.isHidden = true
    }
    func showDeviceNotFound(with text:String) {
        failureBlur.isHidden = false
        failureMessage.text = text
    }
    func stopSearchAnimating() {
        phoneImage.stopAnimating()
    }
    
    func startConnectionAnimating(){
        lineImage.isHidden = false
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
