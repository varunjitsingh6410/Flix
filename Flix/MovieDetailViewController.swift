//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Varun Jit Singh on 12/25/18.
//  Copyright © 2018 Varun Jit Singh. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var bigPoster: UIImageView!
    @IBOutlet weak var lilPoster: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var releaseDateLab: UILabel!
    @IBOutlet weak var summaryLab: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let movie = movie {
            titleLab.text = movie["title"] as? String
            releaseDateLab.text = movie["release_date"] as? String
            summaryLab.text = movie["overview"] as? String
            
            let bigPosStr = movie["backdrop_path"] as! String
            let lilPosStr = movie["poster_path"] as! String
            
            let baseUrl = "https://image.tmdb.org/t/p/w500"
            let bigUrl = URL(string: baseUrl+bigPosStr)!
            let lilUrl = URL(string: baseUrl+lilPosStr)!
            
            bigPoster.af_setImage(withURL: bigUrl)
            lilPoster.af_setImage(withURL: lilUrl)
        }
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
