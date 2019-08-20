//
//  UserDefaultType.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation


enum UserDefaultType {
    case FirstTime
    case FirstTimeConversion
    
    
    func getObjectKey() -> String {
        switch self {
        case .FirstTime:
            return "firstTime"
        case .FirstTimeConversion:
            return "firstTimeConversion"
        }
    }
}
