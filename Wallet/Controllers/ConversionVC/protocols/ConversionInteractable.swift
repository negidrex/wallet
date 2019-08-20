//
//  ConversionInteractable.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation

protocol ConversionInteractable : class {
    func convert(fromWallet: String, toWallet: String, amount: String)
}
