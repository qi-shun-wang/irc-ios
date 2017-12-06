//
//  MenuViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

private let MenuCellIdentifier = "MenuCell"

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var menuListView: UITableView!
    
    var viewModel: MenuViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            viewModel = MenuViewModel(view: self)
        }
        
        //        viewModel?.renderFirstSelectedCellBackground()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.updateHeaderView()
      
    }
    
}


extension MenuViewController: MenuViewControllerProtocol {
    
    func renderMenuHeaderView() {
        headerView.subviews.forEach({ $0.removeFromSuperview() })
        
        guard let userHeaderViewModel = viewModel?.menuHeaderViewModel else {return}
        
        let menuHeaderView = MenuHeaderView(frame: headerView.frame)
        menuHeaderView.viewModel = userHeaderViewModel
        userHeaderViewModel.prepare(menuHeaderView)
        menuHeaderView.setup()
        
        headerView.addSubview(menuHeaderView)
    }
    
    //    func renderFirstSelectedCellBackground() {
    //        let firstIndexPath = IndexPath(row: 0, section: 0)
    //        menuTableView.selectRow(at: firstIndexPath, animated: false, scrollPosition: .top)
    //    }
    //
}

extension MenuViewController :UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCellIdentifier, for: indexPath)
        guard
            let viewModel = viewModel,
            let menuCell = cell as? MenuCell,
            let menuCellViewModel = viewModel.cellViewModel(indexPath)
            else {
                return cell
        }
        
        //Dependency Injection (inject view model into View)
        menuCell.viewModel = menuCellViewModel
        //Dependency Injection (inject view into view model)
        menuCellViewModel.prepare(menuCell)
        menuCell.setup()
        
        return menuCell
    }
    
}

extension MenuViewController :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        guard
        _ = viewModel?.didSelectRowAt(indexPath)
        //            else{return}
        //
        //        let storyboard = UIStoryboard(name:item.storyboard.name, bundle: nil)
        //
        //        guard
        //            let nc = storyboard.instantiateInitialViewController()
        //            else{return}
        //        slideMenuController()?.changeMainViewController(nc, close: true)
        //
    }
    
}
