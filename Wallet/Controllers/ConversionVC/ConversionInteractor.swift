//
//  ConversionInteractor.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation

class ConversionInteractor {
    
    private var httpWorker = HTTPRequestWorker.shared
    private var realmWorker = RealmWorker.shared
    private var userDefaultWorker = UserDefaultWorker.shared
    private var wallets : [Wallet] = []
    private var presenter : ConversionPresentable
    
    private var numberOfAttempts : Int = 0
    
    init(presenter: ConversionPresentable) {
        self.presenter = presenter
        self.wallets = self.realmWorker.fetchAll(type: .Wallet)
        print("Data: \(self.wallets)")
    }
    
    fileprivate func computationAndDeduction(fromWallet: String, toWallet: String, amount: String, convertedAmount: String) {
        let doubleAmount = Double(amount)
        let doubleConvertedAmount = Double(convertedAmount)
        
        if let fromWalletObject = self.wallets.filter({$0.currency.lowercased() == fromWallet.lowercased()}).first {
            let fromwallet = WalletObject()
            fromwallet.currency = fromWalletObject.currency
             fromwallet.balance = fromWalletObject.balance
            
            if validateWalletOutOfBalance(enteredAmount: doubleAmount ?? 0.0, balance: fromwallet.balance) {
                self.presenter.conversionResponse(message: "Wallet Out of Balance")
               return
            }
            
            if !self.validateEmpty(wallet: fromwallet) {
                print("Number of Attempts: \(numberOfAttempts)")
                
                fromwallet.balance -= ((doubleAmount ?? 0.0) + self.deduction(amount: doubleAmount ?? 0.0))
                self.realmWorker.modify(type: .Wallet, data: fromwallet)
                self.numberOfAttempts += 1
                self.userDefaultWorker.store(data: self.numberOfAttempts, type: .FirstTimeConversion)
            } else {
                self.presenter.conversionResponse(message: "Out of Balance")
                return
            }
        } else {
            self.presenter.conversionResponse(message: "No From Wallet Found")
            return
        }
        
        if let toWalletObject = self.wallets.filter({$0.currency.lowercased() == toWallet.lowercased()}).first {
            let towallet = WalletObject()
            towallet.currency = toWalletObject.currency
            towallet.balance = toWalletObject.balance
            print("Balance: \(toWalletObject.balance)")
            towallet.balance += doubleConvertedAmount ?? 0.0
            print("New Balance: \(towallet.balance)")
            self.realmWorker.modify(type: .Wallet, data: towallet)
            
            if self.numberOfAttempts > 5 {
                self.presenter.conversionResponse(message: "Conversion Success! Check your wallet \nCommission Fee:\(self.deduction(amount: doubleAmount ?? 0.0))")
            } else {
                self.presenter.conversionResponse(message: "Conversion Success! Check your wallet")
            }
        } else {
            self.presenter.conversionResponse(message: "No To Wallet Found")
        }
        
    }
    
    fileprivate func validateEmpty(wallet: WalletObject) -> Bool {
        if wallet.balance > 0 {
            return false
        } else {
            return true
        }
    }
    
    fileprivate func validateWalletOutOfBalance(enteredAmount: Double, balance: Double) -> Bool {
        
        if enteredAmount > balance {
            return true
        } else {
            return false
        }
    }
    
    fileprivate func deduction(amount: Double) -> Double {
        
        //Commission if more than 5 conversion
        if self.numberOfAttempts < 5 {
            return 0.0
        } else {
            return amount * 0.007
        }
        
    }
    
}

extension ConversionInteractor : ConversionInteractable {
    func convert(fromWallet: String, toWallet: String, amount: String) {
        self.httpWorker.sendRequestJSONResponse(
            request: .convert(amount: amount, fromCurrency: fromWallet, toCurrency: toWallet),
            onSuccess: { (json) in
                
                self.userDefaultWorker.fetch(type: .FirstTimeConversion, success: { (numberOfConversions: Int) in
                    self.numberOfAttempts = numberOfConversions
                }) { (error) in
                    self.numberOfAttempts = 0
                    self.userDefaultWorker.store(data: 1, type: .FirstTimeConversion)
                }
                
                self.computationAndDeduction(fromWallet: fromWallet, toWallet: toWallet, amount: amount, convertedAmount: json["amount"].stringValue)
        }) { (error) in
            self.presenter.conversionResponse(message: error)
        }
    }
}
