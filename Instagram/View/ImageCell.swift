//
//  ImageCell.swift
//  Instagram
//
//  Created by MTQ on 6/29/20.
//  Copyright © 2020 seesaa. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private weak var moreView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    var isMoreImage: Bool? {
        didSet {
            guard let isMoreImage = isMoreImage else {
                return
            }
            moreView.isHidden = !isMoreImage
        }
    }
}
