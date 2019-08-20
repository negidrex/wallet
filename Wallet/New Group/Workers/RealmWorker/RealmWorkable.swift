//
//  RealmWorkable.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmWorkable : class {
    func add(data: Object)
    func modify<T>(type: RealmObject, data: T )
    func fetchAll<T>(type: RealmObject) -> [T]
    
}
