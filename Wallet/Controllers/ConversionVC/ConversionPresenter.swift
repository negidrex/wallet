//
//  ConversionPresenter.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import Foundation

class ConversionPresenter {
    
    private var viewable : ConversionViewable
    
    init(viewController : ConversionViewable) {
        self.viewable = viewController
    }
    
}

extension ConversionPresenter : ConversionPresentable {
    func conversionResponse(message: String) {
        self.viewable.response(message: message)
    }
}
