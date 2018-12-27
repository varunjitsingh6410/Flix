//
//  HeroViewController.swift
//  Flix
//
//  Created by Varun Jit Singh on 12/26/18.
//  Copyright © 2018 Varun Jit Singh. All rights reserved.
//

import UIKit
import AlamofireImage

class HeroViewController: UIViewController, UICollectionViewDataSource {
    
    var movies:[[String: Any]] = []
    @IBOutlet weak var heroFeed: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        
        if let posterPathStr = movie["poster_path"] as? String {
            let baseUrlStr = "https://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: baseUrlStr+posterPathStr)!
            cell.posterImg.af_setImage(withURL: posterUrl)
        }
        return cell
    }
    
    func fetchMovies() {
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
                self.heroFeed.reloadData()
                
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heroFeed.dataSource = self
        fetchMovies()
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
