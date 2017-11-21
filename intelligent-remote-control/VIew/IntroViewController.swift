//
//  IntroViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var dot: UIPageControl!
    @IBOutlet weak var introImageView: UIImageView!
    @IBOutlet weak var introDescriptionTextView: UITextView!
    @IBOutlet weak var exitButton: UIButton!
    @IBAction func swipeRightGesture(_ sender: UISwipeGestureRecognizer) {
        viewModel?.swipeRight()
    }
    @IBAction func swipeLeftGesture(_ sender: UISwipeGestureRecognizer) {
        viewModel?.swipeLeft()
    }
    @IBAction func exitToMainPage(_ sender: UIButton) {
        viewModel?.exit(to: Storyboard.irc)
    }
    
    var viewModel: IntroViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            viewModel = IntroViewModel(view: self)
        }
        
        dot.numberOfPages = viewModel?.maximumPage() ?? 0
        viewModel?.update(page: dot.currentPage)
    }
    
    deinit {
        print("deinit----->" + debugDescription)
    }
}

extension IntroViewController : IntroViewControllerProtocol {

    func swipeLeft() {
        print("swipe left")
        guard  dot.currentPage < dot.numberOfPages else {return}
        dot.currentPage += 1
        //page dot ++
        viewModel?.update(page: dot.currentPage)
    }
    
    func swipeRight() {
        print("swipe right")
        guard  dot.currentPage > 0 else {return}
        dot.currentPage -= 1
        //page dot --
        viewModel?.update(page: dot.currentPage)
    }
    
    func showExitButton() {
        exitButton.isHidden = false
    }
    
    func hideExitButton(){
        exitButton.isHidden = true
    }
    
    func exit(to storyboard:Storyboard) {
        //change main controller to IRCViewController
        let storyboard = UIStoryboard(name: storyboard.name, bundle:  nil)
        guard
            let nc = storyboard.instantiateInitialViewController()
            else{
                print("not set correct storyboard ")
                return
                
        }
        slideMenuController()?.changeMainViewController(nc, close: true)
        
    }
    
    func render(with description: String, _ imageName: String) {
        //view controll
        introImageView.image = UIImage(named: imageName)
        introDescriptionTextView.text = description
    }
    
}

