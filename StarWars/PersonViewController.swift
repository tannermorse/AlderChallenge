//
//  PersonViewController.swift
//  StarWars
//
//  Created by Tanner Morse on 6/6/18.
//  Copyright © 2018 Tanner Morse. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBAction func answerButtonPressed(_ sender: Any) {
        self.revealAnswer()
    }
    
    var selectedPerson = Individual()
    var themeColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTheme(themeColor: self.setThemecolor())
        self.setupButton()
        self.populateData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
    }

    func populateData() {
        let firstName = selectedPerson.firstName!
        let lastName = selectedPerson.lastName!
        self.nameLabel.text = "\(firstName) \(lastName)"
        let birthday = self.formatDate(roughDate: selectedPerson.birthdate!)
        self.birthdayLabel.text = "It's \(birthday)!"
        self.quoteLabel.text = self.accessTheForce()
        self.profileImageView.image = UIImage(data: selectedPerson.profilePicture! as Data)
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true
    }
    
    func configureTheme(themeColor: UIColor) {
        self.navigationController?.navigationBar.barTintColor = themeColor
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.profileImageView.layer.borderColor = themeColor.cgColor
        self.profileImageView.layer.borderWidth = 3
    }
    
    func setThemecolor() -> UIColor {
        switch selectedPerson.affiliation {
        case "SITH":
            return UIColor.red
        case "JEDI":
            return UIColor.blue
        case "FIRST_ORDER":
            return UIColor.green
        case "RESISTANCE":
            return UIColor.cyan
        default:
            return UIColor.gray
        }
    }
    
    func accessTheForce() -> String {
        switch selectedPerson.forceSensitive {
        case true:
            return "“For my ally is the Force, and a powerful ally it is.” – Yoda"
        case false:
            return "“That’s not how the Force works!” – Han Solo"
        }
    }
    
    func setupButton() {
        self.answerButton.layer.cornerRadius = 25
        self.birthdayLabel.alpha = 0
    }
    
    func revealAnswer() {
        self.birthdayLabel.alpha = 0
        UIView.animate(withDuration: 1.5, animations: {
            self.birthdayLabel.alpha = 1.0
            })
    }
    
    func formatDate(roughDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: roughDate)!
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: date)
    }

}
