//
//  VideoPreview.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/23.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoPreviewDelegate:class {
    func didChangePositionBar(_ playerTime:CMTime)
    func didGenerateThumbnailImage(_ image:UIImage)
    
}

class VideoPreview: AVAssetTimeSelector {
    
    @IBInspectable public var positionBarColor: UIColor = .white {
        didSet {
            positionBar.backgroundColor = positionBarColor
        }
    }
    @IBInspectable public var positionBarWidth: CGFloat = 2 {
        didSet {
            positionBar.frame.size.width = positionBarWidth
        }
    }
    
    /// The selected start time for the current asset.
    public var startTime: CMTime? {
        let startPosition = positionBar.frame.origin.x + assetPreview.contentOffset.x
        return getTime(from: startPosition)
    }
    // MARK: Subviews
    private let positionBar = UIView()
    
    // MARK: Constraints
    private var positionConstraint: NSLayoutConstraint?
    private var currentPositionConstraint: CGFloat = 0
    // MARK: Interface
    public weak var delegate:VideoPreviewDelegate?
    
    
    override func setupSubviews() {
        super.setupSubviews()
        backgroundColor = UIColor.clear
        layer.zPosition = 1
        setupPositionBar()
        setupGestures()
    }
    
    func setupPositionBar(){
        
        positionBar.frame = CGRect(x: 0, y: 0, width: 3, height: frame.height)
        positionBar.backgroundColor = positionBarColor
        positionBar.center = CGPoint(x: frame.minX, y: center.y)
        positionBar.layer.cornerRadius = 1
        positionBar.translatesAutoresizingMaskIntoConstraints = false
        positionBar.isUserInteractionEnabled = false
        addSubview(positionBar)
        
        positionBar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        positionBar.widthAnchor.constraint(equalToConstant: 3).isActive = true
        positionBar.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        positionConstraint = positionBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        positionConstraint?.isActive = true
    }
    func setupGestures(){
        let positionBarPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(VideoPreview.handlePanGesture))
        positionBar.addGestureRecognizer(positionBarPanGestureRecognizer)
    }
    
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer){
        
        guard let view = gestureRecognizer.view, let superView = gestureRecognizer.view?.superview else { return }
        
        let isPositionBarGesture = view == positionBar
        
        switch gestureRecognizer.state {
        case .began:
            if isPositionBarGesture {
                currentPositionConstraint = positionConstraint!.constant
            }
            updateSelectedTime(stoppedMoving: false)
        case .changed:
            let translation = gestureRecognizer.translation(in: superView)
            if isPositionBarGesture {
                updatePositionBarConstraint(with: translation)
            }
            layoutIfNeeded()
            if let startTime = startTime, isPositionBarGesture {
                currentPositionConstraint = positionConstraint!.constant
                seek(to: startTime)
            }
            updateSelectedTime(stoppedMoving: false)
        case .cancelled,.ended,.failed :
            updateSelectedTime(stoppedMoving: true)
        default:
            break
        }
        
    }
    
    private var minimumDistanceBetweenHandle: CGFloat {
        guard let asset = asset else { return 0 }
        return assetPreview.contentView.frame.width / CGFloat(asset.duration.seconds)
    }
    
    private func updatePositionBarConstraint(with translation: CGPoint) {
                let maxConstraint = max(frame.maxX - positionBar.frame.width - minimumDistanceBetweenHandle, 0)
                let newConstraint = min(max(0, currentPositionConstraint + translation.x), maxConstraint)
                positionConstraint?.constant = newConstraint
    }
    private func updateSelectedTime(stoppedMoving: Bool) {}
    
    public func seek(to time: CMTime) {
        if let newPosition = getPosition(from: time) {
            
            let offsetPosition = newPosition - assetPreview.contentOffset.x - positionBar.frame.origin.x
            let maxPosition = frame.maxX - positionBar.frame.width
            let normalizedPosition = min(max(0, offsetPosition), maxPosition)
            positionConstraint?.constant = normalizedPosition
            layoutIfNeeded()
        }
    }

}
