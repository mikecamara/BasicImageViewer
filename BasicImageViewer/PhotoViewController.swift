//
//  PhotoViewController.swift
//  BasicImageViewer
//
//  Created by Admin on 12/9/17.
//  Copyright © 2017 mikecamara.github.io. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var flickrPhoto: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //var flickrPhotos: FlickrPhoto?
    
    var img = UIImage()
    
    var txt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        flickrPhoto.image = img

        
        titleLabel.text = txt

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
