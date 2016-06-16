//
//  MoviesViewController.swift
//  Flix
//
//  Created by Sumedha Mehta on 6/15/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var movies: [NSDictionary]?
 
    var filteredData: [NSDictionary]!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(loadData(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        self.loadData(true)
        filteredData = movies

        // Do any additional setup after loading the view.
    }
    
    func loadData(initial: Bool) {
        
        let apiKey = "41bd51eb709292aba24fa92152fa5604"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue())
        if(initial){
            MBProgressHUD.showHUDAddedTo(self.view, animated: true) }
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                    print("response: \(responseDictionary)")
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    self.filteredData = self.movies
                    self.tableView.reloadData()
                    if(initial) { MBProgressHUD.hideHUDForView(self.view, animated: true) }
                    else {
                        self.refreshControl.endRefreshing()
                    }
                    
                }
            }
        })
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies != nil {
             return filteredData.count
        }
        else {return 0;}
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as! MovieCell
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        cell.posterImg.setImageWithURL(NSURL(string: baseUrl + ((filteredData![indexPath.row]["poster_path"])! as! String) )!) //CHECK LATER
        let movie = movies![indexPath.row]
        let posterpath = movie["poster_path"] as! String
        let imgUrl = NSURL(string: baseUrl + posterpath)
        
        print("row\(indexPath.row)")
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewC = segue.destinationViewController as! MoiveDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let movie = movies![(indexPath?.row)!]
        viewC.movieTitle = movie["title"] as? String
        viewC.movieInfo = movie["overview"] as? String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        if let posterPath = movie["backdrop_path"] as? String{
            viewC.imgURL = NSURL(string: baseUrl + posterPath)
        }
        else {
            let greyURL = "http://www.simplycoatings.co.uk/ekmps/shops/simplycoatings2/images/-70-semi-gloss-powder-coating-20kg-box--1741-p[ekm]288x288[ekm].jpg"
            viewC.imgURL = NSURL(string: greyURL)
        }

        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filteredData = movies
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            filteredData = movies!.filter({(dataItem: NSDictionary) -> Bool in
                // If dataItem matches the searchText, return true to include it
                if (dataItem["title"] as! String).rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                }
                else {
                    return false
                }
            })
        }
        tableView.reloadData()
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


