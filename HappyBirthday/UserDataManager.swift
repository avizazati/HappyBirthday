//
//  MainVCViewModel.swift
//  HappyBirthday
//
//  Created by Avi Sapir on 07/08/2021.
//

import Foundation
import UIKit

class UserDataManager {
    
    static let shaerd = UserDataManager()
    
    func getBabyName() -> String? {
        let babyName = UserDefaults.standard.string(forKey: "BabyName")
        return babyName
    }
    
    func setBabyName(name: String) {
        UserDefaults.standard.setValue(name, forKey: "BabyName")
    }
    
    func setBabyBirhdayDate(date: Date) {
        UserDefaults.standard.set(date.timeIntervalSince1970, forKey: "BabyBirhdayDate")
    }
    
    func getBabyBirthdayDate() -> Date? {
        let timeSince1970 = UserDefaults.standard.double(forKey: "BabyBirhdayDate")
        guard timeSince1970 != 0 else {
            //TODO: what if someone was born in 1970, so maybe he's not a baby anymore?
            return nil
        }
        let date = Date(timeIntervalSince1970: timeSince1970)
        return date
    }
    
    func getBabyBirthdayDateString() -> String? {
        if let date = getBabyBirthdayDate() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            return dateFormatter.string(from: date)
        }
        return nil
    }
        
    func setBabyImage(image: UIImage) {
        
        //save image to docs
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent("babyImage")
            if let data = image.jpegData(compressionQuality: 1.0) {
                do {
                    try data.write(to: fileURL)
                } catch {
                    print("error saving file to documents:", error)
                }
            }
        }
    }
    
    func getBabyImage() -> UIImage? {

        //get the image file from docs
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent("babyImage")
            let image = UIImage(contentsOfFile: fileURL.path)
            return image
        }
        return nil
    }
}
