//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Apple on 27/02/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlets:
    @IBOutlet weak var tableView: UITableView!
    
    lazy var refresh: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(getLatestData), for: .valueChanged)
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Latest Data ...", attributes: attributes)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
       
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresh
        }else {
            tableView.addSubview(refresh)
        }
       
    }
    
   @objc func getLatestData() {
        print("getting you the latest and newest data after refresh")
    
    let deadline = DispatchTime.now() + .seconds(3)
    DispatchQueue.main.asyncAfter(deadline: deadline) {
        self.refresh.endRefreshing()
        print("ending refresh, pulling you the data you requested.")
    }
    
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
            return cell
    }
}
