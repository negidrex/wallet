//
//  WalletViewController.swift
//  Wallet
//
//  Created by Drexler Altarejos on 20/08/2019.
//  Copyright © 2019 Drexler Altarejos. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet private weak var walletTableView: UITableView!
    fileprivate var wallets: [Wallet] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializingCells()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wallets = RealmWorker.shared.fetchAll(type: .Wallet)
        self.walletTableView.reloadData()
    }
    
    private func initializingCells() {
        self.walletTableView.register(UINib(nibName: String(describing: WalletTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WalletTableViewCell.self))
    }
}

extension WalletViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WalletTableViewCell.self), for: indexPath) as! WalletTableViewCell
        cell.wallet = self.wallets[indexPath.row]
        return cell
    }
}
