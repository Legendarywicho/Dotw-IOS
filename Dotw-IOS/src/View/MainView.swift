//
//  MainView.swift
//  Dotw-IOS
//
//  Created by Luis Santiago  on 11/13/17.
//  Copyright © 2017 Luis Santiago. All rights reserved.
//

import Foundation
import UIKit;
import BulletinBoard;


let mainColor  = UIColor.white;
let grayColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1);
let pinkColor = UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1);

protocol DelegateStore : class {
    func onClickResult();
}

class MainView : UIView{
    
    var isConstrainted  = true;
    weak var delegate : StoreDelegate?;
    
    let calculate : UIButton = {
        let button = UIButton(type: .system);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Calculate", for: .normal);
        button.backgroundColor = pinkColor;
        button.setTitleColor(.white , for: .normal);
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        button.layer.cornerRadius = 20;
//        button.layer.borderWidth = 1
        return button;
    }();
    
    let container : UIView = {
        let view  = UIView();
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    let errorImage : UIImageView = {
        let errorImg = UIImageView ();
        errorImg.translatesAutoresizingMaskIntoConstraints = false;
        errorImg.image = #imageLiteral(resourceName: "icons8-attention(4)");
        errorImg.contentMode = UIViewContentMode.right;
        errorImg.isHidden = true;
        
        return errorImg;
    }();
    
    let resultGuideNUmbers : UITextView = {
        let textView = UITextView();
        textView.translatesAutoresizingMaskIntoConstraints = false;
        textView.text = "Insert the numbers";
        textView.backgroundColor = mainColor;
        textView.isEditable = false;
        textView.isSelectable = false;
        textView.font = .systemFont(ofSize: 16);
        return textView;
    }();
    
    
    let resultMeanTextView : UITextView = {
        let textView = UITextView();
        textView.translatesAutoresizingMaskIntoConstraints = false;
        textView.text = "";
        textView.backgroundColor = mainColor;
        textView.isEditable = false;
        textView.isSelectable = false;
        textView.font = .systemFont(ofSize: 20);
        return textView;
    }();
    
    let resultMeanDesviationTextView : UITextView = {
        let textView = UITextView();
        textView.translatesAutoresizingMaskIntoConstraints = false;
        textView.text = "";
        textView.backgroundColor = mainColor;
        textView.isEditable = false;
        textView.isSelectable = false;
        textView.font = .systemFont(ofSize: 20);
        return textView;
    }();
    
    let resultInputNumbersTextView : UITextView = {
        let textView = UITextView();
        textView.translatesAutoresizingMaskIntoConstraints = false;
        textView.textAlignment = .center;
        textView.isEditable = false;
        textView.isSelectable = false;
        textView.font = .boldSystemFont(ofSize: 20);
        textView.text = "";
        return textView;
    }();
    
    
    let inputText : UITextField = {
        let textView = UITextField();
        textView.translatesAutoresizingMaskIntoConstraints = false;
        textView.placeholder = "Example : 2,4,5,6,7";
        textView.layer.borderWidth = 1.0
        textView.backgroundColor = grayColor;
        textView.layer.borderColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0).cgColor
        textView.layer.masksToBounds = true;
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50));
        textView.leftView = paddingView
        textView.leftViewMode = UITextFieldViewMode.always
        textView.addTarget(nil, action: Selector(("firstResponderAction:")), for:.editingDidEndOnExit);
        return textView;
    }();
    
    let scrollView : UIScrollView = {
        let scroll = UIScrollView();
        scroll.translatesAutoresizingMaskIntoConstraints = false;
        scroll.alwaysBounceVertical = true;
        scroll.isUserInteractionEnabled = true;
        scroll.isExclusiveTouch = true;
        scroll.canCancelContentTouches = true;
        scroll.delaysContentTouches = false;
        return scroll;
    }();
    
    func setUpImageError(){
        //adding the error image
        inputText.addSubview(errorImage);
        errorImage.topAnchor.constraint(equalTo: inputText.topAnchor, constant : 25).isActive = true;
        errorImage.leftAnchor.constraint(equalTo: inputText.leftAnchor).isActive = true;
        errorImage.rightAnchor.constraint(equalTo: inputText.rightAnchor, constant : -3).isActive = true;
        errorImage.bottomAnchor.constraint(equalTo: inputText.bottomAnchor, constant : -25).isActive = true;
    }
    
    func initView(){
        self.backgroundColor = mainColor;
        self.addSubview(scrollView);
        scrollView.addSubview(calculate);
        scrollView.addSubview(resultGuideNUmbers);
        scrollView.addSubview(inputText);
        
        //Adding container view to the other textView
        scrollView.addSubview(container)
        container.addSubview(resultMeanTextView);
        container.addSubview(resultMeanDesviationTextView);
        container.addSubview(resultInputNumbersTextView);
        setUpImageError();
        seUpConstraintsForLayout();
    }
    
    
    func seUpConstraintsForLayout(){
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true;
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true;
        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true;
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        //Number constraints
        resultGuideNUmbers.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true;
        resultGuideNUmbers.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant : 20).isActive = true;
        resultGuideNUmbers.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant : -20 ).isActive = true;
        resultGuideNUmbers.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        //input constraints
        inputText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true;
        inputText.topAnchor.constraint(equalTo: resultGuideNUmbers.bottomAnchor, constant : -13).isActive = true;
        inputText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true;
        inputText.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        //Button constraints
        calculate.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant : 30).isActive = true;
//        calculate.widthAnchor.constraint(equalTo:scrollView.widthAnchor, multiplier : 1).isActive = true;
        calculate.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        calculate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true;
        calculate.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true;
    
        
        //container constraints
        container.topAnchor.constraint(equalTo: calculate.bottomAnchor).isActive = true;
        container.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true;
        container.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true;
        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
        container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
        
        //Set this for the container

        resultMeanTextView.topAnchor.constraint(equalTo: container.topAnchor, constant : 30).isActive = true;
        resultMeanTextView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant : 20).isActive = true;
        resultMeanTextView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant : -20 ).isActive = true;
        resultMeanTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true;


        resultMeanDesviationTextView.topAnchor.constraint(equalTo: resultMeanTextView.bottomAnchor, constant : 20).isActive = true;
        resultMeanDesviationTextView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant : -20 ).isActive = true;
        resultMeanDesviationTextView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant : 20).isActive = true;
        resultMeanDesviationTextView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant : -20 ).isActive = true;
        resultMeanDesviationTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true;

        resultInputNumbersTextView.topAnchor.constraint(equalTo: resultMeanDesviationTextView.bottomAnchor, constant : 20).isActive = true;
        resultInputNumbersTextView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true;
        resultInputNumbersTextView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant : 20).isActive = true;
        resultInputNumbersTextView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant : -20 ).isActive = true;
        resultInputNumbersTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if isConstrainted {
            initView();
            isConstrainted = false;
        }
        super.updateConstraints();
    }
    
    @objc func onClick(){
        delegate?.onClick();
        
    }
    
}

extension UITextField{
    // Source : https://stackoverflow.com/questions/27987048/shake-animation-for-uitextfield-uiview-in-swift
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
