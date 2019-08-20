//
//  UserDefaultWorker.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation

class UserDefaultWorker {
    
    public static var shared : UserDefaultWorkable = UserDefaultWorker()
    fileprivate var userDefault = UserDefaults.standard
    
}

extension UserDefaultWorker : UserDefaultWorkable {
    func store<T>(data: T, type: UserDefaultType) {
        self.userDefault.set(NSKeyedArchiver.archivedData(withRootObject: data), forKey: type.getObjectKey())
    }
    
    func fetch<T>(type: UserDefaultType, success: @escaping (T) -> Void, failed: ((_ message: String) -> Void)) {
        
        if let data = self.userDefault.data(forKey: type.getObjectKey()) {
            if let object = NSKeyedUnarchiver.unarchiveObject(with: data) as? T {
                success(object)
            } else {
                failed("Unable to unarchive data")
            }
        } else {
            failed("No Data found")
        }
    }
}
