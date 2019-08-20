//
//  HTTPRequestWorkable.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HTTPRequestWorkable : class {
    func sendRequestJSONResponse(request: Request, onSuccess: @escaping((_ data: JSON ) -> Void), onError: @escaping((_ message: String) -> Void))
}
