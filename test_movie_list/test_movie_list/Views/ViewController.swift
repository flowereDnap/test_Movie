//
//  ViewController.swift
//  test_movie_list
//
//  Created by mac on 29.07.2024.
//

import UIKit

class MovieListView: UITableViewController{
    
    @IBOutlet var table: UITableView!
    
    private var movies: [Movie] = []
    private var currentPage = 1
    private var isLoading = false
    
    
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
        
        fetchMovies(page: 1)
        
        
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
    
    func fetchMovies(page: Int) {
            guard !isLoading else { return }
            isLoading = true
        
            NetworkManager.shared.fetchRatedMovies(page: page) { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let rMovies):
                    let movies = rMovies.results.map{ Movie(from: $0) }
                    self.movies.append(contentsOf: movies)
                    self.table.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
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
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configure(title: movie.title, genre: movie.genres[0].name, rating: String(movie.vote_average), imageName: "Image")
        return cell
    }
    

    

}

