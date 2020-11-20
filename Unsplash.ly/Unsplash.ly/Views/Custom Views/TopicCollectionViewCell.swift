//
//  TopicCollectionViewCell.swift
//  Unsplash.ly
//
//  Created by Nicholas Towery on 11/19/20.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
       
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }

    static func nib() -> UINib {
        return UINib(nibName: "TopicCollectionViewCell", bundle: nil)
    }
}
