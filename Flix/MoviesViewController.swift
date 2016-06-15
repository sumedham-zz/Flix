//
//  MoviesViewController.swift
//  Flix
//
//  Created by Sumedha Mehta on 6/15/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let apiKey = "41bd51eb709292aba24fa92152fa5604"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                        print("response: \(responseDictionary)")
                        self.movies = responseDictionary["results"] as? [NSDictionary]
                        
                        self.tableView.reloadData()
                                                                                
                    }
                }
        })
        task.resume()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
             return movies.count
        }
        else {return 0;}
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath:indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterpath = movie["poster_path"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let imgUrl = NSURL(string: baseUrl + posterpath)
        cell.movieLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterImg.setImageWithURL(imgUrl!)
        
        print("row\(indexPath.row)")
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
