//
//  UserDefaultWorkable.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation

protocol UserDefaultWorkable : class {
    func store<T>(data: T, type: UserDefaultType)
    func fetch<T>(type: UserDefaultType, success: @escaping(_ data: T) -> Void, failed: ((_ message: String) -> Void))
}
