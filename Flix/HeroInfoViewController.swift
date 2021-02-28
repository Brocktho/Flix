//
//  HeroInfoViewController.swift
//  Flix
//
//  Created by Brock Donahue on 2/27/21.
//

import UIKit
import AlamofireImage

class HeroInfoViewController: UIViewController {
    var movie: [String:Any]!
    
    @IBOutlet weak var movieInfo: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.text = movie["title"] as? String
        movieInfo.text = movie["overview"] as? String
        
        let posterPath = movie["poster_path"] as! String
        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
        
        let posterUrl = URL(string: posterBaseUrl + posterPath)!
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropBaseUrl = "https://image.tmdb.org/t/p/w780"
        
        let backdropUrl = URL(string: backdropBaseUrl + backdropPath)!
        
        backdropImage.af_setImage(withURL: backdropUrl)
        moviePoster.af_setImage(withURL: posterUrl)
        // Do any additional setup after loading the view.
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
