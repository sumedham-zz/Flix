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
    
    var imgURL: NSURL?
    var movieTitle: String?
    var movieInfo: String?
    var movieRating: String?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        detailImg.setImageWithURL(imgURL!)
        detailTitle.text = movieTitle;
        detailInfo.text = movieInfo;
        detailRating.text = "\(String(movieRating!))/10"
    

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onMore(sender: AnyObject) {
        let openLink = NSURL(string : "https://www.google.com")
        UIApplication.sharedApplication().openURL(openLink!)
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
