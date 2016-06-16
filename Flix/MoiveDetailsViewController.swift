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
    
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    var imgURL: NSURL?
    var movieTitle: String?
    var movieInfo: String?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        detailImg.setImageWithURL(imgURL!)
        detailTitle.text = movieTitle;
        detailInfo.text = movieInfo;

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
