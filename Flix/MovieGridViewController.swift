//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Brock Donahue on 2/27/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var movies = [[String:Any]]()
    

    @IBOutlet weak var collectionView: UICollectionView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 3
        layout.itemSize = CGSize(width: width, height: width * (4/3))
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.collectionView.reloadData()
           }
        }
        task.resume()
        
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.item]
        
        let posterPath = movie["poster_path"] as! String
        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
        
        let posterUrl = URL(string: posterBaseUrl + posterPath)!
        
        cell.moviePoster.af_setImage(withURL: posterUrl)
        
        return cell
         
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
        
        // Pass the selected object to the new view controller.
        let infoViewController = segue.destination as! HeroInfoViewController
        infoViewController.movie = movie
    }

}
