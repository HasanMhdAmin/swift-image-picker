//
//  ImageItem.swift
//  PhotoGallery
//
//  Created by Hasan Mhd Amin on 13.01.21.
//

import Foundation

class ImageItem: Codable, NSCopying {
    
    var name: String
    var isSelected = false
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, isSelected: Bool) {
        self.name = name
        self.isSelected = isSelected
    }
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        return ImageItem(name: self.name, isSelected: self.isSelected)
    }
    
}
