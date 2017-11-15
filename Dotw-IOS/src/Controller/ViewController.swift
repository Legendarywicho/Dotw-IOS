//
//  ViewController.swift
//  Dotw-IOS
//
//  Created by Luis Santiago  on 11/13/17.
//  Copyright © 2017 Luis Santiago. All rights reserved.
//

import UIKit
import BulletinBoard;

class ViewController: UIViewController, StoreDelegate {
    
    var staticsFunctions  = StatisticFuntions();
    var isValidated = false;
    var mShowDialogue : Bool!;
    
    let secondCardView : PageBulletinItem = {
        let page = PageBulletinItem(title: "The power of statics in your hands");
        page.descriptionText = "Separate the numbers using a coma";
        page.actionButtonTitle = "Start"
        page.image = #imageLiteral(resourceName: "Instructions");
        page.isDismissable = true;
        page.actionHandler = { (item: PageBulletinItem) in
            item.manager?.dismissBulletin(animated:true);
        }
        return page;
    }();
    
    
    lazy var bulletinManager: BulletinManager = {
        let page = PageBulletinItem(title: "Dowt")
        page.descriptionText = "Calculate the average and mean deviation."
        page.actionButtonTitle = "Next"
        page.nextItem = secondCardView;
        page.image = #imageLiteral(resourceName: "Logo");
        page.actionHandler = { (item: PageBulletinItem) in
            item.displayNextItem()
        }
        return BulletinManager(rootItem: page)
    }();
    
    

    var displayValueMean : Double{
        
        get {
            return staticsFunctions.mean(collection:parseArray(numbers: mainLayout.inputText.text!))
        }
        
        set {
            mainLayout.resultMeanTextView.text = String("Average : \(newValue)");
        }
    }
    
    var displayValueMeanDesviation : Double{
        get {
            return staticsFunctions.reduceDecimal(with: staticsFunctions.meanVariations(numbers:parseArray(numbers: mainLayout.inputText.text!)));
        }
        
        set {
            mainLayout.resultMeanDesviationTextView.text = String("Mean Deviation : \(newValue)");
        }
    }
    
    var displayValue : String{
        get {
            return mainLayout.inputText.text!
        }
        
        set {
            mainLayout.resultGuideNUmbers.text = String(newValue);
        }
    }
    
    
    func parseArray(numbers : String)->[Double]{
        var parseArray = [Double]();
            let array = numbers.split(separator: ",");
            for number in array {
                let parseNumber =  Double(number);
                if (parseNumber != nil) {
                    parseArray.append(parseNumber!);
                    isValidated = true;
                }
                else{
                    print("There was an error");
                    isValidated = false;
                    onError();
                }
            }
        return parseArray;
    }
    
    func onError(){
        print("Error");
        mainLayout.inputText.shake();
        mainLayout.errorImage.isHidden = false;
    }
    
    func onClick() {
        print("checking the state is \(isValidated)");
        checkValidation();
    }
    
    func checkValidation(){
        let answer = mainLayout.inputText.text!;
        let letters = NSCharacterSet.letters;
        let range = answer.rangeOfCharacter(from: letters);
        
        //Check empty data and letters
        if  (range != nil) || answer == "" {
            onError();
            print("There are letters");
        }else{
            //Mean
            let mean = displayValueMean;
            displayValueMean = mean;
            
            //Mean Desviation
            let meanDesviation = displayValueMeanDesviation;
            displayValueMeanDesviation = meanDesviation;
            
            //Show the result of :  Average + desviation
            // and average - desviation
            let differenceOfResult = mean - meanDesviation;
            let sumOfResult = mean + meanDesviation
            mainLayout.resultInputNumbersTextView.text = String("\(differenceOfResult) , \(sumOfResult)");
            //Removing the error image
            mainLayout.errorImage.isHidden = true;
            
            dismisKeyboard();
        }
    }
    
    
    let mainLayout : MainView = {
        let main = MainView(frame: CGRect.zero);
        main.translatesAutoresizingMaskIntoConstraints = false;
        return main;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar();
        setUpView();
        mainLayout.delegate = self;
        //Checking if we should show bulletin board
        if mShowDialogue! {
            showBulletinBoard();
        }
    }
    
    func setUpView(){
        self.view.addSubview(mainLayout);
        self.view.backgroundColor = .white;
        mainLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainLayout.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainLayout.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainLayout.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setUpNavBar(){
        navigationItem.title = "Dotw";
        navigationController?.navigationBar.prefersLargeTitles = true;
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent;
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func showBulletinBoard(){
        bulletinManager.backgroundViewStyle = .blurredExtraLight
        bulletinManager.prepare()
        bulletinManager.presentBulletin(above: self)
        UserDefaults.standard.set("done", forKey: "dialog");
    }
    
    func dismisKeyboard(){
        print("Dismising keyboarc");
        self.view.endEditing(true);
    }
}

