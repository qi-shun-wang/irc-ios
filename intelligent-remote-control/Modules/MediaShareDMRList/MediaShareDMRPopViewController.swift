//
//  MediaShareDMRPopViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

protocol MediaShareDMRPopViewControllerDelegate: class {
    func didSelect(device:DMR)
    
}

class MediaShareDMRPopViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    weak var delegate:MediaShareDMRPopViewControllerDelegate?
    weak var dlnaManager:DLNAMediaManager?
    var devices:[DMR] = []{
        didSet{
            tableView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dlnaManager?.startDiscover()
        dlnaManager?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dlnaManager?.stopDiscover()
        dlnaManager = nil
    }
    
}

extension MediaShareDMRPopViewController:DLNAMediaManagerDelegate {
    func didFind(device: DMR) {
         devices.append(device)
    }
    
    func didRemove(at index: Int) {
         devices.remove(at: index)
    }
    
    func didFailureChangeVolume() {
        
    }
    
    func didFailureChangeMute() {
       
    }
    
    func didChangeMute() {
        
    }
    
    func didChangeVolume() {
        
    }
    
    func didSetupTransportService() {
        
    }
    
    func didSetupRenderService() {
        
    }
    
    
}
extension MediaShareDMRPopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let device = devices[indexPath.row]
        dismiss(animated: true) {
            
            self.delegate?.didSelect(device: device)
        }
        
    }
}
extension MediaShareDMRPopViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell") ?? UITableViewCell()
        let device = devices[indexPath.row]
        
        cell.textLabel?.text = device.name
//        cell.imageView?.image = UIImage(named:device.iconFileName)
        return cell
    }
    
   
}
