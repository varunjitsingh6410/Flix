//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Varun Jit Singh on 12/13/18.
//  Copyright © 2018 Varun Jit Singh. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies: [[String: Any]] = []
    

    
    @IBOutlet weak var movieFeed: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieFeed.dataSource = self
        movieFeed.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        movieFeed.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                
                // TODO: Get the array of movies
                let movies = dataDictionary["results"] as! [[String:Any]]
                for movie in movies {
                    let title = movie["title"] as! String
                    print (title)
                }
                // TODO: Store the movies in a property to use elsewhere
                self.movies = movies
                
                // TODO: Reload your table view data
                self.movieFeed.reloadData()
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieFeed.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseUrl + posterPath)!
        
        cell.poster.af_setImage(withURL: posterURL)
        cell.titleLabel.text = title as! String
        cell.summaryLabel.text = overview as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200.0//Choose your custom row height
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        // Do any additional setup after refreshing the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                
                // TODO: Get the array of movies
                let movies = dataDictionary["results"] as! [[String:Any]]
                for movie in movies {
                    let title = movie["title"] as! String
                    print (title)
                }
                // TODO: Store the movies in a property to use elsewhere
                self.movies = movies
                
                // TODO: Reload your table view data
                self.movieFeed.reloadData()
            }
        }
        refreshControl.endRefreshing()
        task.resume()
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
