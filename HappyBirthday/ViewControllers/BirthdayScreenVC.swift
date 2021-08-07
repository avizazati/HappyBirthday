//
//  BirthdayScreenVC.swift
//  HappyBirthday
//
//  Created by Avi Sapir on 07/08/2021.
//

import UIKit

enum BirthDayScreenDesign {
    case Fox
    case Elephant
    case Bird
}

class BirthdayScreenVC: UIViewController {
    
    let vm = BirthdayScreenViewModel()
    
    var birthDayScreenDesign = BirthDayScreenDesign.Fox
    
    
    let nanitBlue = UIColor(red: 218/255.0, green: 241/255.0, blue: 246/255.0, alpha: 1.0) // for bird
    let nanitGreen = UIColor(red: 197/255.0, green: 232/255.0, blue: 223/255.0, alpha: 1.0) // for fox
    let nanitYellow = UIColor(red: 254/255.0, green: 239/255.0, blue: 203/255.0, alpha: 1.0) // for elephant


    @IBOutlet weak var todayTextLabel: UILabel!
    @IBOutlet weak var ageNumberImageView: UIImageView!
    @IBOutlet weak var oldTextLabel: UILabel!
    @IBOutlet weak var babyBirthdayImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var bg_imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //random design
        let random = Int.random(in: 0..<3)
        switch random {
        case 0:
            birthDayScreenDesign = BirthDayScreenDesign.Fox
        case 1:
            birthDayScreenDesign = BirthDayScreenDesign.Elephant
        case 2:
            birthDayScreenDesign = BirthDayScreenDesign.Bird
        default:
            birthDayScreenDesign = BirthDayScreenDesign.Fox
        }
    
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
   
        //round the baby image
        self.babyBirthdayImageView.layer.cornerRadius = self.babyBirthdayImageView.frame.height / 2
        self.babyBirthdayImageView.clipsToBounds = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        self.todayTextLabel.text = vm.getTodayLabelText()
        self.oldTextLabel.text = vm.getOldLabelText()
        self.ageNumberImageView.image = UIImage(named: vm.getImageNameForBabyAge())
        if let babyImage = vm.getBabyBirthdayImage() {
            self.babyBirthdayImageView.image = babyImage

        }
        
    }
    
    func setupUI() {
        
        //bg image
        switch birthDayScreenDesign {
        case .Fox:
            //Green
            self.view.backgroundColor = nanitGreen
            self.cameraButton.setImage(UIImage(named: "cameraIconGreen"), for: .normal)
            self.babyBirthdayImageView.image = UIImage(named: "defaultPlaceHolderGreen")
            bg_imageView.image = UIImage(named: "bg_birthday_fox")
            
        case .Bird:
            //Blue
            self.view.backgroundColor = nanitBlue
            self.cameraButton.setImage(UIImage(named: "cameraIconBlue"), for: .normal)
            self.babyBirthdayImageView.image = UIImage(named: "defaultPlaceHolderBlue")

            bg_imageView.image = UIImage(named: "bg_birthday_bird")

        case .Elephant:
            //Yellow
            self.view.backgroundColor = nanitYellow
            self.cameraButton.setImage(UIImage(named: "cameraIconYellow"), for: .normal)
            self.babyBirthdayImageView.image = UIImage(named: "defaultPlaceHolderYellow")
            bg_imageView.image = UIImage(named: "bg_birthday_elephant")

        }
        
        //flip share button, icon to the right
        shareButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        shareButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        shareButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        shareButton.layer.cornerRadius = shareButton.frame.size.height / 2
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraButtonClick(_ sender: Any) {
        
        //choose image from gallery or camera roll
        ImagePickerManager().pickImage(self) { image in
            
            //save the image
            UserDataManager.shaerd.setBabyImage(image: image)

            //display the image
            self.babyBirthdayImageView.image = image

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func shareButtonClick(_ sender: Any) {
        // image to share
        
        //hide some views
        self.shareButton.alpha = 0
        self.cameraButton.alpha = 0
        self.backButton.alpha = 0
        
        if let image = UIImage(view: self.view) {
            // set up activity view controller
            let imageToShare = [ image ]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
     
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
        
        //reverse hide views
        self.shareButton.alpha = 1
        self.cameraButton.alpha = 1
        self.backButton.alpha = 1

    }
    
}
