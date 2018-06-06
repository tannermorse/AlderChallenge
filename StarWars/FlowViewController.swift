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
    var aoIndividuals  = [Individual]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushIndividualsViewController()
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pushIndividualsViewController() {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "IndividualsVC") as! IndividualsViewController
        vc.flowdelegate = self
        self.pushViewController(vc, animated: true)
    }

    func PushIndividualProfile(individual: Individual) {
        
    }
}
