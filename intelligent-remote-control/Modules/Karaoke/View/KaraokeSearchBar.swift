//
//  KaraokeSearchBar.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/13.
//  Copyright © 2018年 ising99. All rights reserved.
//

import SnapKit

protocol KaraokeSearchBarDelegate {
    func didTapOnSearchField()
    func didCancelOnSearchField()
    func didChangeSearchText(_ text:String)
}
class KaraokeSearchBar: UIView {
    
    lazy var textField:UITextField = UITextField()
    lazy var searchIcon:UIImage? = UIImage(named: "search")
    lazy var settingIcon:UIImage? = UIImage(named: "setting")
    lazy var settingHighlightedIcon:UIImage? = UIImage(named: "setting_highlighted")
    lazy var image:UIImageView = UIImageView(image: searchIcon)
    lazy var contentView:UIView = UIView()
    lazy var settingBtn:UIButton = UIButton()
    lazy var cancelBtn:UIButton = UIButton()
    
    public var settingDispatchAction:Callback?
    public var cancelDispatchAction:Callback?
    public var delegate:KaraokeSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @objc private func settingAction(){
        settingDispatchAction?()
    }
    
    @objc private func cancelAction(){
        showSettingButton()
        textField.resignFirstResponder()
        cancelDispatchAction?()
    }
    private func commonInit(){
        addSubview(contentView)
        addSubview(settingBtn)
        addSubview(cancelBtn)
         contentView.backgroundColor = UIColor.main_background_color
        cancelBtn.isHidden = true
        textField.delegate = self
        textField.returnKeyType = .search
        textField.backgroundColor = .clear//.blue
        textField.textColor = .white
        settingBtn.backgroundColor = .clear//.yellow
        contentView.backgroundColor = UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1)
        textField.attributedPlaceholder = NSAttributedString(string: "請輸入歌手、歌名",
                                                             attributes:[NSAttributedStringKey.foregroundColor : UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)])
        settingBtn.setImage(settingIcon, for: .normal)
        settingBtn.setImage(settingHighlightedIcon, for: .highlighted)
        settingBtn.contentMode = .scaleAspectFit
        settingBtn.imageView?.contentMode = .scaleAspectFit
        settingBtn.addTarget(self, action: #selector(self.settingAction), for: .touchUpInside)
        
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(.white, for: .normal)
        cancelBtn.addTarget(self, action: #selector(self.cancelAction), for: .touchUpInside)
        cancelBtn.titleLabel?.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(textField)
        contentView.addSubview(image)
        contentView.layer.cornerRadius = 10
       
        let contentWidth:CGFloat = UIScreen.main.bounds.width/5
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-contentWidth)
        }
        
        settingBtn.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(contentView.snp.right)
            make.right.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalTo(contentView.snp.right)
            make.right.equalToSuperview()
        }
        
        image.contentMode = .scaleAspectFit
        
        image.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
            make.height.equalTo(image.snp.width)
        }
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.left.equalTo(image.snp.right).offset(4)
            make.right.equalToSuperview().offset(-4)
        }
        
    }
    fileprivate func showCancelButton(){
        settingBtn.isHidden = true
        cancelBtn.isHidden = false
    }
    fileprivate func showSettingButton(){
        settingBtn.isHidden = false
        cancelBtn.isHidden = true
    }
}
extension KaraokeSearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didTapOnSearchField()
        showCancelButton()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let word = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        delegate?.didChangeSearchText(word)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didCancelOnSearchField()
        showSettingButton()
    }
}
