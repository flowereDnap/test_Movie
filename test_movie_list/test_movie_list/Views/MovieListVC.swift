//
//  ViewController.swift
//  test_movie_list
//
//  Created by mac on 29.07.2024.
//

import UIKit

class MovieListView: UITableViewController{
    
    @IBOutlet var table: UITableView!
    
    private let movies = ["yes yes", "dub dub"]
    
    private let noDataLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "There are no Movies yet, refresh to update"
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .gray
            return label
        }()
    
    private let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNoDataLabel()
        setupRefreshControl()
        setupTableView()
        
        
        
        // Do any additional setup after loading the view.
    }

    private func setupTableView() {
        table.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 200
    }
    
    private func setupNoDataLabel() {
           view.addSubview(noDataLabel)
           
           // Center the noDataLabel in the view
           NSLayoutConstraint.activate([
               noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               noDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               noDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])
           
           noDataLabel.isHidden = true // Initially hide the label
    }
    
    private func setupRefreshControl() {
            myRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
            // Reload the data and end refreshing
            loadMovies()
        }
    
    private func loadMovies() {
           tableView.reloadData()
           updateNoDataLabelVisibility()
           myRefreshControl.endRefreshing() // Stop the refresh control animation
    }
       
    private func updateNoDataLabelVisibility() {
           noDataLabel.isHidden = !movies.isEmpty
    }
    
    func presentActionSheet() {
            // Create the action sheet
            let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
            
            // Add option buttons
            actionSheet.addAction(UIAlertAction(title: "Option 1", style: .default, handler: { action in
                //TODO
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Option 2", style: .default, handler: { action in
                //TODO
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Option 3", style: .default, handler: { action in
                //TODO
            }))
            
            // Add cancel button
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            // Present the action sheet
            present(actionSheet, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configure(title: "Title", genre: "genre", rating: "5", imageName: "Image")
        return cell
    }
    

    

}

