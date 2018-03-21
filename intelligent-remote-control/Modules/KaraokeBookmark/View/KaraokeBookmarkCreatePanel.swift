//
//  KaraokeBookmarkCreatePanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/21.
//  Copyright © 2018年 ising99. All rights reserved.
//

import SnapKit

class KaraokeBookmarkCreatePanel: UIView {

    private let nibIdentifier = "KaraokeBookmarkCreatePanel"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var title: UILabel!
    
    public var createDispatch:StringCallback?
    
    @IBAction func cancelAction(_ sender: UIButton) {
        isHidden = true
        _ = textFieldShouldReturn(nameField)
    }
    
    @IBAction func createAction(_ sender: UIButton) {
        createDispatch?(nameField.text ?? "")
        isHidden = true
        _ = textFieldShouldReturn(nameField)
    }
    
    func setupConstraints(){
        
        container.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(nameField.snp.top)
        }
        
        nameField.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalToSuperview().dividedBy(6)
        }
        
        createBtn.snp.makeConstraints { (make) in
            make.top.equalTo(nameField.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(cancelBtn.snp.left).offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(nameField.snp.bottom).offset(32)
            make.width.equalTo(createBtn)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let pink:UIColor = UIColor(red:219/255.0, green:67/255.0, blue:127/255.0, alpha: 1)
        let purple:UIColor = UIColor(red:138/255.0, green:0/255.0, blue:137/255.0, alpha: 1)
        cancelBtn.applyGradient(colours: [pink,purple], locations: [0,1])
        createBtn.applyGradient(colours: [pink,purple], locations: [0,1])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    /**
     Common initialization of view. Creates UIButton instances for base and handle.
     */
    private func initialize(){
        Bundle.main.loadNibNamed(nibIdentifier, owner: self, options: nil)
        backgroundColor = UIColor(white: 0, alpha: 0)
        isOpaque = false
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        setupConstraints()
        container.layer.cornerRadius = 20
        cancelBtn.layer.cornerRadius = 20
        createBtn.layer.cornerRadius = 20
        title.text = "新增歌單名稱"
        nameField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : Int = Int(keyboardSize.height)
            print("keyboardHeight",keyboardHeight)
            container.snp.updateConstraints { (make) in
                make.centerY.equalToSuperview().offset(-keyboardHeight/2)
            }
        }
        
    }
   
    @objc func keyboardWillDisappear(_ notification: NSNotification?) {
        container.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview()
        }
    }
    
    deinit{
        print("removeObserver")
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide , object: nil)
    }
}

extension KaraokeBookmarkCreatePanel:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 
        return textField.resignFirstResponder()
    }
}
