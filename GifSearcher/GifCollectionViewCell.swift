//
//  GifCollectionViewCell.swift
//  GifSearch
//
//  Created by BOTTAK on 11/23/19.
//  Copyright © 2019 BOTTAK. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class GifCollectionViewCell: UICollectionViewCell {
    
    var gif: GifModel? {
        didSet {
            if let gif = gif, let url = gif.url {
                imageView.sd_setImage(with: URL.init(string: url))
            }
            if let gif = gif, let trended = gif.trended, trended == true { // check if it's necessary to add trended icon
                trendedImageView = UIImageView.init(image: UIImage.init(named: Constants.trendedIconName))
            }
        }
    }
    
    var imageView: FLAnimatedImageView!
    var trendedImageView: UIImageView? {
        didSet {
            if let trendedImageView = trendedImageView {
                trendedImageView.frame = CGRect(x: Constants.cellPadding * 2, y: Constants.cellPadding * 2, width: Constants.trendedIconSize, height: Constants.trendedIconSize)
                self.addSubview(trendedImageView)
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? GifLayoutAttributes {
            if imageView == nil {
                imageView = FLAnimatedImageView()
                imageView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
                self.addSubview(imageView)
            }
            // update image view size according to gif size
            imageView.frame = CGRect(x: Constants.cellPadding, y: Constants.cellPadding, width: attributes.gifWidth, height: attributes.gifHeight)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if imageView != nil {
            imageView.animatedImage = nil
        }
        if trendedImageView != nil {
            trendedImageView?.removeFromSuperview()
            trendedImageView = nil
        }
    }
    
}
