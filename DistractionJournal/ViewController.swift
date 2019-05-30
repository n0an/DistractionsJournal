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
        
        
        getDistractions()
        
        addObsever()
    }
    
    func addObsever() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "distractionNotification"), object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                self.getDistractions()
            }
        }
    }
    
    func getDistractions() {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = Distraction.fetchRequest() as NSFetchRequest<Distraction>
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d h:mma"
        
        let distraction = distractions[indexPath.row]
        
        cell.textLabel?.text = "\(distraction.name ?? "Empty") - \(formatter.string(from: distraction.date ?? Date()))"
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}
