//
//  ConversionViewController.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
    
    public var isKeyboardShown : Bool = false
    @IBOutlet weak var convertBtnBotConst: NSLayoutConstraint!
    @IBOutlet weak var fromCurrencyLbl: UILabel!
    @IBOutlet weak var fromCurrencyView: UIView!
    @IBOutlet weak var toCurrencyLbl: UILabel!
    @IBOutlet weak var toCurrencyView: UIView!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var instructionLbl: UILabel!
    
    private var toAlert : UIAlertController!
    private var fromAlert : UIAlertController!
    private var wallets : [Wallet] = []
    private var fromCurrency : String = ""
    private var toCurrency : String = ""
    
    private var interactor : ConversionInteractable!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactor = ConversionInteractor(presenter: ConversionPresenter(viewController: self))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDismiss(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.getAllWallet()
        self.initializeActionSheet()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        self.fromCurrencyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showFromAlertVC)))
        self.toCurrencyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showToAlertVC)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.instructionLbl.text = "Complete the form"
    }
    
    @IBAction func btnActions(_ sender: UIButton) {
        self.interactor.convert(fromWallet: self.fromCurrencyLbl.text ?? "", toWallet: self.toCurrencyLbl.text ?? "", amount: self.amountTF.text ?? "")
        self.view.endEditing(true)
    }
    
    @objc public func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.convertBtnBotConst.constant += keyboardSize.height * 0.5
                UIView.animate(withDuration: 0.5) {
                    self.view.frame.origin.y -= keyboardSize.height * 0.5
                    self.view.layoutIfNeeded()
                    
                }
            }
        }
    }
    
    
    @objc public func keyboardWillDismiss(notification: NSNotification){
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.convertBtnBotConst.constant = 0
                UIView.animate(withDuration: 0.5) {
                    self.view.frame.origin.y = 0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc public func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    private func getAllWallet() {
        self.wallets = RealmWorker.shared.fetchAll(type: .Wallet)
    }
    
    private func initializeActionSheet(){
        self.toAlert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        self.fromAlert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        for wallet in self.wallets {
            self.toAlert.addAction(UIAlertAction(title: "\(wallet.currency.uppercased())", style: .default , handler:{ (UIAlertAction)in
                self.toCurrencyLbl.text = wallet.currency.uppercased()
            }))
            
            self.fromAlert.addAction(UIAlertAction(title: "\(wallet.currency.uppercased())", style: .default , handler:{ (UIAlertAction)in
                self.fromCurrencyLbl.text = wallet.currency.uppercased()
            }))
        }
    }
    
    @objc private func showToAlertVC(){
        self.present(self.toAlert, animated: true, completion: nil)
    }
    
    @objc private func showFromAlertVC(){
        self.present(self.fromAlert, animated: true, completion: nil)
    }
}

extension ConversionViewController : ConversionViewable {
    func response(message: String) {
        self.instructionLbl.text = message
    }
}


