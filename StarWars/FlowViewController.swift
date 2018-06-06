//
//  FlowViewController.swift
//  StarWars
//
//  Created by Tanner Morse on 6/5/18.
//  Copyright © 2018 Tanner Morse. All rights reserved.
//

import UIKit
import CoreData

class FlowViewController: UINavigationController, individualsViewControllerDelegate {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushIndividualsViewController()
    }

    func pushIndividualsViewController() {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "IndividualsVC") as! IndividualsViewController
        vc.flowdelegate = self
        self.pushViewController(vc, animated: true)
    }

    func PushIndividualProfile(individual: Individual) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "PersonVC") as! PersonViewController
        vc.title = individual.affiliation?.replacingOccurrences(of: "_", with: " ")
        vc.selectedPerson = individual
        self.pushViewController(vc, animated: true)
    }
}
