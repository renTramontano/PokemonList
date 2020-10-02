//
//  PageTableViewController.swift
//  PokemonAPI-Example
//
//  Created by Christopher Jennewein on 6/30/18.
//  Copyright © 2018 Prismatic Games. All rights reserved.
//

import UIKit


/// A delegate for selecting a page
protocol PageSelectDelegate: class {
    /// Returns the index of the page selected. The pages are 0-indexed, so "Page 1" is index 0.
    func didSelectPageIndex(_ pageIndex: Int)
}



/// A ViewController that lists pages up to the `pageCount`, starting at 1. Uses the PageSelectDelegate to relay which page was selected by the user.
class PageTableViewController: UITableViewController {
    public var pageCount = 0
    
    public weak var delegate: PageSelectDelegate?
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSize(width: 100, height: 400)
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell")

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        cell.textLabel?.text = "Page \(indexPath.row + 1)"

        return cell
    }
    
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.didSelectPageIndex(indexPath.row)
        self.dismiss(animated: true)
    }
}
