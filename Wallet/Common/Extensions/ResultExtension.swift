//
//  ResultExtension.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation
import RealmSwift

//extension Results {
//    
//    func toArray() -> [T] {
//        return self.map{$0}
//    }
//}
//

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
