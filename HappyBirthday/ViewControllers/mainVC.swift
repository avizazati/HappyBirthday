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
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let image = UserDataManager.shaerd.getBabyImage() {
            self.avatarImageView.image = image
        }
        
        if let name =  UserDataManager.shaerd.getBabyName() {
            self.nameTextFiled.text = name
        }
        
        if let dateString = UserDataManager.shaerd.getBabyBirthdayDateString() {
            self.dateTextField.text = dateString
        }
        
        shouldEnableShowBirhdayButton()
    }
    
    func setupUI() {
        
        //round the avatar image
        self.avatarImageView.layer.borderWidth = 1
        self.avatarImageView.layer.borderColor = UIColor.black.cgColor
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height/2
        self.avatarImageView.clipsToBounds = true
        
        //round the button
        self.showBirthdayButton.layer.cornerRadius = 15
        self.showBirthdayButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.showBirthdayButton.setTitleColor(.white, for: .normal)
        
        //set date picker as input for date textField
        self.dateTextField.addInputViewDatePicker(target: self, selector: #selector(datePickerDoneButtonPressed))
        
        //set the delegates
        self.dateTextField.delegate = self
        self.nameTextFiled.delegate = self
    }
    

        
    //MARK: Buttons
    @IBAction func editImageButtonClick(_ sender: Any) {
        
        //choose image from gallery or camera roll
        ImagePickerManager().pickImage(self) { image in
            
            //save the image
            UserDataManager.shaerd.setBabyImage(image: image)

            //display the image
            self.avatarImageView.image = image

        }
    }
    
    @IBAction func showBirthdayButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func BGInvisibleButtonClick(_ sender: Any) {
        dismissAllKeyboards()
    }
    
    
    //MARK: TextFields delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameTextFiled {
            //save the baby name
            if let name = textField.text {
                UserDataManager.shaerd.setBabyName(name: name)
            }
        }
        shouldEnableShowBirhdayButton()
    }
    
    func dismissAllKeyboards() {
        //dismiss all keyboards
        nameTextFiled.resignFirstResponder()
        dateTextField.resignFirstResponder()
    }
    
    //MARK: Date Picker
    @objc func datePickerDoneButtonPressed() {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker {
            //save the date
            UserDataManager.shaerd.setBabyBirhdayDate(date: datePicker.date)
            //display the date
            self.dateTextField.text = UserDataManager.shaerd.getBabyBirthdayDateString()
        }
        self.dateTextField.resignFirstResponder()
     }
    
    //MARK: Logic
    func shouldEnableShowBirhdayButton() {
        
        //The ShowBirthday button should be enable only if 'date and name' are not empty.
        let nameText = nameTextFiled.text ?? ""
        let dateText = dateTextField.text ?? ""

        if nameText.count > 0 && dateText.count > 0 {
            showBirthdayButton.isEnabled = true
            showBirthdayButton.alpha = 1.0
        }else {
            showBirthdayButton.isEnabled = false
            showBirthdayButton.alpha = 0.3
        }
    }
}
