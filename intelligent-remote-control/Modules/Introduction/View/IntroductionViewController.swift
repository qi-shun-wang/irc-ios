//
//  IntroductionViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class IntroductionViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    
    var presenter: IntroductionPresentation?
    
    // MARK: Lifecycle
    @IBOutlet weak var dot: UIPageControl!
    @IBOutlet weak var introImageView: UIImageView!
    @IBOutlet weak var introDescriptionTextView: UITextView!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBAction func swipeRightGesture(_ sender: UISwipeGestureRecognizer) {
        presenter?.swipeRight()
    }
    @IBAction func swipeLeftGesture(_ sender: UISwipeGestureRecognizer) {
        presenter?.swipeLeft()
    }
    @IBAction func exitToMainPage(_ sender: UIButton) {
        presenter?.exit()
    }
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    deinit {
        print("deinit----->" + debugDescription)
    }
}

extension IntroductionViewController: IntroductionView {
    // TODO: implement view output methods
    func setupPage(_ total: Int) {
        dot.numberOfPages = total
    }
    func showExit() {
        exitButton.isHidden = false
    }
    func hideExit() {
        exitButton.isHidden = true
    }
    func render(_ currentPage: Int) {
        dot.currentPage = currentPage
    }
    
    func render(with description: String, _ imageName: String) {
        introImageView.image = UIImage(named: imageName)
        introDescriptionTextView.text = description
    }
}
