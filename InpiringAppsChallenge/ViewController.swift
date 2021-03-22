//
//  ViewController.swift
//  InpiringAppsChallenge
//
//  Created by Calbert, Deron on 3/7/21.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = ViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.dataSource = self
        
        super.viewDidLoad()
        viewModel.getLogs(){ _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
}
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewSequences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sequence:String = viewModel.tableViewSequences[indexPath.row].sequence.joined(separator: " -> ")
        cell.textLabel?.text = sequence
        
        return cell
        
    }
    
    
}

