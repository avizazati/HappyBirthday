//
//  BirthdayScreenViewModel.swift
//  HappyBirthday
//
//  Created by Avi Sapir on 07/08/2021.
//

import Foundation
import UIKit


class BirthdayScreenViewModel {
    
    func getTodayLabelText() -> String {
        if let name =  UserDataManager.shaerd.getBabyName() {
            return "TODAY \(name.uppercased()) IS"
        }
        return ""
    }
    
    func getOldLabelText() -> String {
        if let years =  UserDataManager.shaerd.getBabyYears() {
            if years > 0 {
                return years != 1 ? "YEARS OLD" : "YEAR OLD"
            }else if let months =  UserDataManager.shaerd.getBabyMonths() {
                return  months != 1 ? "MONTHS OLD" : "MONTH OLD"
            }
        }
        return ""
    }
    
    func getImageNameForBabyAge() -> String {
        
        if let years =  UserDataManager.shaerd.getBabyYears() {
            if years > 0 {
               return String(years)
            }else if let months =  UserDataManager.shaerd.getBabyMonths() {
                return String(months)
            }
        }
        return "0"
    }
    
    func getBabyBirthdayImage() -> UIImage? {
        return UserDataManager.shaerd.getBabyImage()
    }
    
    
}
