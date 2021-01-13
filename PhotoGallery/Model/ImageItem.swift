//
//  ImageItem.swift
//  PhotoGallery
//
//  Created by Hasan Mhd Amin on 13.01.21.
//

import Foundation

class ImageItem: Codable {
    var name: String
    var isSelected = false
    
    init(name: String) {
        self.name = name
    }
}
