//
//  Wallet.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation
import RealmSwift

class Wallet : Object {
    @objc dynamic var currency : String = ""
    @objc dynamic var balance : Double = 0.0

}

class WalletObject {
    var currency : String = ""
    var balance : Double = 0.0
}
