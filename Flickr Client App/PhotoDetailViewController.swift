//
//  PhotoDetailViewController.swift
//  Flickr Client App
//
//  Created by mustafa yildiz on 29.08.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Detail"
        imageView.backgroundColor = .blue
        ownerImageView.backgroundColor = .yellow
        ownerNameLabel.text = "Owner Name"
        descriptionLabel.text = "Description Label Description Label Description Label"
        
    }
    

   
}
