//
//  ResultViewController.swift
//  SlideshowApp
//
//  Created by UI3 on 2024/11/11.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
        }
    }
}
