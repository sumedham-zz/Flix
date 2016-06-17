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
    
    
    
   //OUTLETS
    @IBOutlet weak var topFilms: UIButton!
    @IBOutlet weak var recentFilms: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    //VARIABLES
    var refreshControl = UIRefreshControl()
    var movies: [NSDictionary]? //holds all movies for mode poplular OR current
    var filteredData: [NSDictionary]? //is edited with search
    var movieData: NSDictionary? //Gets data for movie for imdb url
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(loadData(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        self.loadData(true)
        filteredData = movies
        clickedRecent(recentFilms)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        topFilms.titleLabel?.textColor  = UIColor.grayColor() //makes grey color for buttons
    }
    
    func loadData(initial: Bool) { //loads data for RECENT MOVIES
        
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
    
    func loadDataTop(initial: Bool) { //loads data for TOP movies
        let apiKey = "41bd51eb709292aba24fa92152fa5604"
        let url = NSURL(string: "http://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)")
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
    
    func getURL(name: String, initial: Bool) //gets url based on movie name
    {
        let plusName = String(name.characters.map {
            $0 == " " ? "+" : $0
            })
        print(plusName)
        let url = NSURL(string: "http://www.omdbapi.com/?t=\(plusName)&y=&plot=short&r=json")
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
                    self.movieData = responseDictionary
                    
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
             return filteredData!.count
        }
        else {return 0;} //no of cells = no of cells in filteredData
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as! MovieCell
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        cell.posterImg.setImageWithURL(NSURL(string: baseUrl + ((filteredData![indexPath.row]["poster_path"])! as! String) )!) //CHECK LATER
        let movie = movies![indexPath.row]
        let posterpath = movie["poster_path"] as! String //only displaying a poster image for each film
        let imgUrl = NSURL(string: baseUrl + posterpath)
        
        print("row\(indexPath.row)")
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //prepare to go to details view
        let viewC = segue.destinationViewController as! MoiveDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let movie = filteredData![(indexPath?.row)!]
        viewC.movieTitle = movie["title"]as! String //title, overview, vote_average, and image are set
        viewC.movieInfo = movie["overview"] as! String
        viewC.movieRating = movie["vote_average"]?.stringValue
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String{
            viewC.imgURL = NSURL(string: baseUrl + posterPath)
        }
        else {
            let greyURL = "http://www.simplycoatings.co.uk/ekmps/shops/simplycoatings2/images/-70-semi-gloss-powder-coating-20kg-box--1741-p[ekm]288x288[ekm].jpg"
            viewC.imgURL = NSURL(string: greyURL) // if image is not there, display grey box
        }

        
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) { //search divides each data item int a dictionary, then searches through movie title
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
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) { //show search bar button
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) { //Search is cancelled, all movies are shown
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewDidLoad()
        
    }
    
    @IBAction func clickedRecent(sender: AnyObject) { //Recent Movies Button is Clicked, color changes, movie data for recent movies is shown
        topFilms.titleLabel?.textColor  = UIColor.grayColor()
        recentFilms.titleLabel?.textColor = UIColor.blueColor()
        loadData(false)
    }
    
    
    @IBAction func clickedTop(sender: AnyObject) { //Popular Movies button is Clicked, color changes, movie data for pop movies is shown
        topFilms.titleLabel?.textColor = UIColor.redColor()
        recentFilms.titleLabel?.textColor = UIColor.grayColor()
        loadDataTop(false)
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


