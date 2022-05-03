//
//  AsyncImageView.swift
//  notFirebase
//
//  Created by adam smith on 5/3/22.
//

import Foundation
import UIKit.UIImage

class ImageCache {
    static let shared = ImageCache()
    var cache = NSCache<NSString, UIImage>()
}
