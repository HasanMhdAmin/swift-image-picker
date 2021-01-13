//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Hasan Mhd Amin on 13.01.21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var images : [ImageItem] = []

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// print the document path (for testing)
        let pathToPrint = FileManager.default.urls(for: .documentDirectory,
                                                   in: .userDomainMask).first
        print("path to print: \(String(describing: pathToPrint))")
        ///
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.progressBar.setProgress(0.0, animated: false)
        downloadImages()
    }
    
    
    func downloadImages() {
        for num in 1...50 {
            Utils.downloadFile(from: "https://placehold.it/120x120&text=" + String(num), to: String(num) + ".jpg") { (path, fileName) in
                
                // add the downloaded image name to the list
                self.images.append(ImageItem(name: fileName))
                DispatchQueue.main.async {
                    let progress = Utils.scale(oldMin: 1, oldMax: 50, newMin: 0.0, newMax: 1.0, value: Float(num))
                    self.progressBar.setProgress(progress, animated: true)
                }
            }
        }
    }
    
    @IBAction func selectImagePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToSelectImage"{
            let photoPickerVC = segue.destination as! PhotoPickerViewController
            let imageToSend = images.map { $0.copy() as! ImageItem }  // different array with same objects
            photoPickerVC.images = imageToSend
            photoPickerVC.result = self
            photoPickerVC.allowMultiSelection = true
        }
    }
    
}

// MARK: - Handle Selected Images
extension ViewController : ImageSelectCallback {
    func onImagesSelected(images: [UIImage]) {
        print(images.count)
        if !images.isEmpty {
            imageView.image = images[0] // Show the first image
        }
    }
}
