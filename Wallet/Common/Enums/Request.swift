//
//  Request.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation
import Alamofire

enum Request {
    
    case convert(amount: String, fromCurrency: String, toCurrency: String)
    
    public func getRequestConfiguration() -> (url: String, header: HTTPHeaders, method: HTTPMethod, body: Parameters?, urlEncoding: ParameterEncoding) {
        
        switch self {
        case .convert(let amount, let fromCurrency, let toCurrency):
            return (
                "http://api.evp.lt/currency/commercial/exchange/\(amount)-\(fromCurrency)/\(toCurrency)/latest",
                [:],
                .get,
                [:],
                Alamofire.URLEncoding.default
            )
        }
        
    }
}
