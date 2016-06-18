//
//  MoiveDetailsViewController.swift
//  Flix
//
//  Created by Sumedha Mehta on 6/16/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import AFNetworking

class MoiveDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var viewMore: UIButton!
    
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    
    var imgURL: NSURL?
    var movieTitle: String?
    var movieInfo: String?
    var movieRating: String?
    var imdbID: String?
    var movieRatingD: Double?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        detailImg.setImageWithURL(imgURL!)
        detailTitle.text = movieTitle;
        detailInfo.text = movieInfo;
        GetImage(movieRatingD!)
        
    

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onMore(sender: AnyObject) {
        let name = String(movieTitle!)
        let url = "http://www.imdb.com/find?ref_=nv_sr_fn&q=\(name)+&s=all"
        print(url)
        let remoteUrl = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        print(remoteUrl)
        UIApplication.sharedApplication().openURL(remoteUrl!)
    }
    
    func GetImage(rating: Double)    {
        if (rating < 2)
        {
        }
        else if (rating >= 2 && rating < 4)
        {
            star1.image=UIImage(named: "Image1")
        }
        else if(rating >= 4 && rating < 6) {
            star1.image=UIImage(named: "Image1")
            star2.image=UIImage(named: "Image1")
        }
        else if(rating >= 6 && rating < 8 ) {
            star1.image=UIImage(named: "Image1")
            star2.image=UIImage(named: "Image1")
            star3.image=UIImage(named: "Image1")
        }
        
        else if(rating >= 6 && rating < 8) {
            star1.image=UIImage(named: "Image1")
            star2.image=UIImage(named: "Image1")
            star3.image=UIImage(named: "Image1")
            star4.image=UIImage(named: "Image1")
            
        }
        else if(rating >= 10){
            star1.image=UIImage(named: "Image1")
            star2.image=UIImage(named: "Image1")
            star3.image=UIImage(named: "Image1")
            star4.image=UIImage(named: "Image1")
            star5.image=UIImage(named: "Image1")
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

}
