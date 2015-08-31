//
//  ImageSizer.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/20/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class ImageSizer {
  class func resizeImage(image : UIImage, size : CGSize) -> UIImage {
    
    UIGraphicsBeginImageContext(size)
    image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
