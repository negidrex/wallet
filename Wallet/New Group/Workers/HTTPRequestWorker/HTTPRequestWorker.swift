//
//  HTTPRequestWorker.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HTTPRequestWorker {
    
    public static var shared : HTTPRequestWorkable = HTTPRequestWorker()
    
}

extension HTTPRequestWorker : HTTPRequestWorkable {
    func sendRequestJSONResponse(request: Request, onSuccess: @escaping ((JSON) -> Void), onError: @escaping ((String) -> Void)) {
        Alamofire.request(request.getRequestConfiguration().url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? request.getRequestConfiguration().url, method: request.getRequestConfiguration().method, parameters: request.getRequestConfiguration().body, encoding: request.getRequestConfiguration().urlEncoding, headers: request.getRequestConfiguration().header).responseJSON { (data) in
            
            if let _response = data.response {
                
                if _response.statusCode >= 200 && _response.statusCode < 300 {
                    
                    switch data.result {
                        
                    case .success(let results):
                        
                        onSuccess(JSON(results))
                        
                    case .failure(_):
                        
                        onError("Failed Response")
                    }
                    
                } else {
                    onError("Error Status Code: \(_response.statusCode)")
                }
                
            } else {
                onError("Response Null")
            }
        }

    }
}
