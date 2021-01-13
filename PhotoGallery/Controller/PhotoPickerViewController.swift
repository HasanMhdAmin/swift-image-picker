//
//  PhotoPickerViewController.swift
//  PhotoGallery
//
//  Created by Hasan Mhd Amin on 13.01.21.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoPickerViewController: UICollectionViewController {

    // variables will be passed from the previous CV
    var images : [ImageItem] = []
    var allowMultiSelection = false
    var result : ImageSelectCallback?

    var lastSelectedItemIndex : Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = images[indexPath.row]
        item.isSelected = !item.isSelected
        
        if !allowMultiSelection {
            if lastSelectedItemIndex != -1 {
                let item = images[lastSelectedItemIndex]
                item.isSelected = !item.isSelected
            }
            lastSelectedItemIndex = indexPath.row
        }
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as! ItemCollectionViewCell
        let item = images[indexPath.row]
        cell.bind(with: item)
        return cell
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        
        var imagesResult : [UIImage] = []
        for i in images {
            if i.isSelected {
                let image = Utils.getImageFromLocal(imageName: i.name)
                if let existedImage = image {
                    imagesResult.append(existedImage)
                }
            }
        }
        
        // return the selected images
        result?.onImagesSelected(images: imagesResult)
        
        // go back
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension PhotoPickerViewController: UICollectionViewDelegateFlowLayout {
    
    // I need to improve this function to find a good way to define how many columns I want in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
        
        ////////////
        //        let inset: CGFloat = 10
        //        let minimumInteritemSpacing: CGFloat = 1
        //        let cellsPerRow = 3
        //
        //        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        //        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        //        return CGSize(width: itemWidth, height: itemWidth)
        ////////////
        
        
        
        //        let screenRect = UIScreen.main.bounds
        //        let screenWidth = screenRect.size.width
        //        let cellWidth = screenWidth / 2.0
        //        return CGSize(width: cellWidth, height: cellWidth)
        //
        
    }
}
