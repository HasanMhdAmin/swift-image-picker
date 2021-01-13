//
//  Utils.swift
//  PhotoGallery
//
//  Created by Hasan Mhd Amin on 13.01.21.
//

import Foundation
import Alamofire

class Utils {
    
    
    // MARK: - Local Storage
    static func saveDataToFile(this data : Data?, to file : String) {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent(file)
        if let stringData = data {
            try? stringData.write(to: path)
        }
    }
    
    static func downloadFile(from url : String, to fileName: String) {
        AF.request(url).response { (data) in
            Utils.saveDataToFile(this: data.data, to: fileName)
        }
    }
    
    static func downloadFile(from url : String, to fileName: String, callback: @escaping (String, String) -> Void) {
        
        AF.request(url).response { (data) in
            
            let path = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)[0].appendingPathComponent(fileName)
            if let stringData = data.data {
                try? stringData.write(to: path)
                callback(String(describing: path), fileName)
            }
        }
    }
    
    static func getImageFromLocal(imageName: String) -> UIImage? {
        let fileURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent(imageName)
        if let file = fileURL {
            if let imageData = NSData(contentsOf: file) {
                let image = UIImage(data: imageData as Data)
                return image
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    
    // MARK: - Math
    
    static func scale(oldMin: Float, oldMax: Float, newMin: Float, newMax: Float, value: Float) -> Float {
        
        //       (b-a)(x - min)
        //f(x) = --------------  + a
        //          max - min
        let result: Float
        let numerator = (newMax - newMin) * (value - oldMin)
        let denominator = oldMax - oldMin
        result = numerator / denominator + newMin
        return result
    }
    
}
