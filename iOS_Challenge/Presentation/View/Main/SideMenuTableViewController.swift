//
//  SideMenuTableViewController.swift
//  iOS_Challenge
//
//  Created by 大川葵 on 2019/07/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit

// MARK: - SideMenuTableViewController
final class SideMenuTableViewController: UITableViewController {
    
    
    deinit {
        print("deinit:\(ObjectIdentifier(self).hashValue)")
    }
    // MARK: ViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("didload:\(ObjectIdentifier(self).hashValue)")
        
        self.navigationItem.title = "メニュー"
        self.navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white ]
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.menuItems.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter?.menuItems[indexPath.row] ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.tapCell(indexPath)
    }
    
    // MARK: Internal
    
    var presenter: SideMenuTableViewPresenter?
}
