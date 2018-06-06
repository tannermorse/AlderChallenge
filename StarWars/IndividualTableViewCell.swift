//
//  IndividualTableViewCell.swift
//  StarWars
//
//  Created by Tanner Morse on 6/6/18.
//  Copyright © 2018 Tanner Morse. All rights reserved.
//

import UIKit

class IndividualTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func renderCell(individual: Individual) {
        self.nameLabel.text = "\(individual.firstName!) \(individual.lastName!)"
        self.profileImageView.image = UIImage(data: individual.profilePicture! as Data)
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true
        self.accessoryType = .disclosureIndicator
    }

}
