//
//  ViewController.swift
//  DistractionJournal
//
//  Created by nag on 29/05/2019.
//  Copyright © 2019 Anton Novoselov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var distractions = [Distraction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "distractionNotification"), object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                self.getDistractions()
            }
        }
    }
    
    func getDistractions() {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = Distraction.fetchRequest() as NSFetchRequest<Distraction>
        
        if let distr = try? context?.fetch(fetchRequest) {
            self.distractions = distr
            
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = distractions[indexPath.row].name
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}
