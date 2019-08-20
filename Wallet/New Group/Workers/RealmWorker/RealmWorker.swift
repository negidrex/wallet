//
//  RealmWorker.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWorker {
    
    public static var shared : RealmWorkable = RealmWorker()
    private var userDefaultWorker = UserDefaultWorker.shared
    
    public var realm : Realm!
    
    init() {
        self.realm = try! Realm()
        
        self.userDefaultWorker.fetch(type: .FirstTime, success: { (firstTime : Bool) in
            
            if firstTime == false {
                print("Already has balance")
            } else {
                self.userDefaultWorker.store(data: false, type: .FirstTime)
                self.initializeWallet()
            }
            
        }) { (error) in
            self.userDefaultWorker.store(data: false, type: .FirstTime)
            self.initializeWallet()
        }
        
    }
    
    private func initializeWallet() {
        
        let euro = Wallet()
        euro.currency = "eur"
        euro.balance = 1000
        self.add(data: euro)
        
        let jpy = Wallet()
        jpy.currency = "jpy"
        jpy.balance = 0
        self.add(data: jpy)
        
        let usd = Wallet()
        usd.currency = "usd"
        usd.balance = 0
        self.add(data: usd)
        
    }
    
}


extension RealmWorker : RealmWorkable {
    
    func fetchAll<T>(type: RealmObject) -> [T] {
        
        switch type {
        case .Wallet:
            return self.realm.objects(Wallet.self).toArray(type: T.self)
        }
        
    }
    
    func add(data: Object) {
        try! self.realm.write {
            realm.add(data)
        }
    }
    
    func modify<T>(type: RealmObject, data: T) {
        print("DAta: \(data)")
        switch type {
        case .Wallet:
            if let wallet = data as? WalletObject {
                let realmWallets = self.realm.objects(Wallet.self)
                let realmWallet =  realmWallets.filter({$0.currency == wallet.currency}).first
                print("Wallet: \(realmWallet)")
                try! self.realm.write {
                    print("Modified")
                    realmWallet?.balance = wallet.balance
                }

            } else {
                print("Cannot modified")
            }
        }
    }
    
//    func fetch<T>(type: RealmObject, key: String, value: String) {
//        switch type {
//        case .Wallet:
//            let realmWallet = self.realm.objects(Wallet.self).filter("\(key) = \(value)")
//            return realmWallet.first
//        }
//    }
}
