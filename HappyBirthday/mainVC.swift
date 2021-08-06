//
//  mainVC.swift
//  HappyBirthday
//
//  Created by Avi Sapir on 05/08/2021.
//

import UIKit

class mainVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var showBirthdayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Happy birthday!"
        self.showBirthdayButton.isEnabled = false
        self.nameTextFiled.delegate = self
        self.dateTextField.delegate = self
        
    }
    
    //MARK: Buttons
    @IBAction func editImageButtonClick(_ sender: Any) {
    }
    @IBAction func showBirthdayButtonClick(_ sender: Any) {
    }
    
  
    @IBAction func BGInvisibleButtonClick(_ sender: Any) {
        dismissAllKeyboards()
    }
    
    
    //MARK: TextFields delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        shouldEnableShowBirhdayButton()
    }
    
    func dismissAllKeyboards() {
        //dismiss all keyboards
        nameTextFiled.resignFirstResponder()
        dateTextField.resignFirstResponder()
    }
    
    //MARK: Logic
    func shouldEnableShowBirhdayButton() {
        
        //The ShowBirthday button should be enable only if 'date and name' are not empty
        
        let nameText = nameTextFiled.text ?? ""
        let dateText = dateTextField.text ?? ""

        if nameText.count > 0 && dateText.count > 0 {
            showBirthdayButton.isEnabled = true
        }else {
            showBirthdayButton.isEnabled = false
        }
    }
}
