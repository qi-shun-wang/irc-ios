//
//  KaraokeBookmarkEditPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/20.
//  Copyright © 2018年 ising99. All rights reserved.
//

import SnapKit

class KaraokeBookmarkEditPanel: UIView {
    
    private let nibIdentifier = "KaraokeBookmarkEditPanel"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var editNameField: UITextField!
    
    public var textDispatchAction:StringCallback?
    
    @IBAction func editAction(_ sender: UIButton) {
        name.isHidden = true
        editNameField.isHidden = false
        cancelBtn.isHidden = false
        editBtn.isHidden = true
        editNameField.text = name.text
        editNameField.becomeFirstResponder()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
       dismiss()
    }
    
    private func dismiss() {
        name.isHidden = false
        editNameField.isHidden = true
        cancelBtn.isHidden = true
        editBtn.isHidden = false
        editNameField.resignFirstResponder()
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
        addSubview(contentView)
        backgroundColor = UIColor(white: 0, alpha: 0)
        isOpaque = false
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        let pink = UIColor(red:228/255.0, green:73/255.0, blue:124/255.0, alpha: 1)
        let purple = UIColor(red:111/255.0, green:0/255.0, blue:115/255.0, alpha: 1)
        contentView.applyGradient(colours: [pink,purple], locations: [0,1])
        
        cancelBtn.isHidden = true
        editNameField.isHidden = true
        editNameField.backgroundColor = .clear
        editNameField.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        editNameField.textColor = .white
        editNameField.tintColor = .white
        editNameField.delegate = self
        name.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        name.textColor = .white
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(.white, for: .normal)
        cancelBtn.titleLabel?.font =  UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        
        
        name.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(editBtn.snp.left).offset(-8)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        editNameField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(editBtn.snp.left).offset(-8)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        editBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(snp.height)
            make.height.equalTo(snp.height)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(snp.height)
            make.height.equalTo(snp.height)
        }
    }
    
}
extension KaraokeBookmarkEditPanel: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textDispatchAction?(textField.text ?? "Field Not Found")
        name.text = textField.text
        dismiss()
        return textField.resignFirstResponder()
    }
}
