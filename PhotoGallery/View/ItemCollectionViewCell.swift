//
//  ItemCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Hasan Mhd Amin on 13.01.21.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var border: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    static let id = "Cell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func bind(with item: ImageItem) {
        let image = Utils.getImageFromLocal(imageName: item.name)
        imageView.image = image
        let backgroundColor = item.isSelected ? UIColor.blue : UIColor.white
        border.backgroundColor = backgroundColor
    }

    static func nib() -> UINib {
        return UINib(nibName: "ItemCollectionViewCell", bundle: nil)
    }
}
