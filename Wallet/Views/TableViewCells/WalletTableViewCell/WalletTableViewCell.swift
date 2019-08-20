//
//  WalletTableViewCell.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell {

    @IBOutlet private weak var currencyImg: UIImageView!
    @IBOutlet private weak var currencyLbl: UILabel!
    
    public var wallet : Wallet! {
        didSet{
            
            switch self.wallet.currency {
            case "eur":
                self.currencyImg.image = UIImage(named: "icon_euro")
            case "jpy":
                self.currencyImg.image = UIImage(named: "icon_jpy")
            case "usd":
                self.currencyImg.image = UIImage(named: "icon_usd")
            default:
                self.currencyImg.image = nil
            }
            
            self.currencyLbl.text = String(format: "$%.2f", self.wallet.balance)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
