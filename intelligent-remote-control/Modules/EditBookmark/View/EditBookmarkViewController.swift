//
//  EditBookmarkViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/26.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class EditBookmarkViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
 
    weak var titleField:UITextField?{
        didSet{
            titleField?.becomeFirstResponder()
        }
    }
    weak var addressField:UITextField?
    
    var presenter: EditBookmarkPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        presenter!.viewDidLoad()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .white
    }
    
}

extension EditBookmarkViewController: EditBookmarkView {
    // TODO: implement view output methods
}




extension EditBookmarkViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter!.didSelect(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(presenter!.heightForHeader(in:section))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(presenter!.heightForRooter(in:section))
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.textAlignment = .right
    }
}

extension EditBookmarkViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter!.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter!.titleForHeader(in:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellInfo = presenter!.cellInfoForRow(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellInfo.identifier, for: indexPath)
        if cell is EditBookmarkCell {
            
            titleField = (cell as! EditBookmarkCell).title
            addressField = (cell as! EditBookmarkCell).address
            (cell as! EditBookmarkCell).title.delegate = self
            (cell as! EditBookmarkCell).address.delegate = self
        } else {
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = cellInfo.text
            cell.imageView?.image = UIImage(named:cellInfo.icon)
            cell.indentationLevel = cellInfo.indentationLevel
            cell.indentationWidth = CGFloat(cellInfo.indentationWidth)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in:section)
    }
    
}

extension EditBookmarkViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter!.shrinkingTable()
    }
    
    
}

extension EditBookmarkViewController: EditFolderView {
    
    // TODO: implement view output methods
    func setupNavigationTitle(with text:String){
        title = text
    }
    
    func expandingTable(with deletePaths:[IndexPath],_ insertPaths:[IndexPath]){
        tableView.beginUpdates()
        tableView.deleteRows(at: deletePaths, with: .fade)
        tableView.insertRows(at: insertPaths, with: .fade)
        tableView.endUpdates()
    }
    
    func shrinkingTable(with deletePaths:[IndexPath],_ insertPaths:[IndexPath]){
        tableView.beginUpdates()
        tableView.deleteRows(at: deletePaths, with: .fade)
        tableView.insertRows(at: insertPaths, with: .fade)
        tableView.endUpdates()
    }
    
    func dismissKeyboard() {
        if let field1 = titleField, let field2 = addressField {
            _ = textFieldShouldReturn(field1)
            _ = textFieldShouldReturn(field2)
        }
    }
    
}
