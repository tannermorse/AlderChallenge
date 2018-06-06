//
//  ViewController.swift
//  StarWars
//
//  Created by Tanner Morse on 6/4/18.
//  Copyright © 2018 Tanner Morse. All rights reserved.
//

import UIKit
import Foundation
import CoreData

protocol individualsViewControllerDelegate {
    func PushIndividualProfile(individual: Individual)
}

class IndividualsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var IndividualsTableView: UITableView!
    var flowdelegate: individualsViewControllerDelegate?
    var aoIndividuals  = [Individual]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = self.aoIndividuals[0].firstName
        Individual.parseArticle(tableView: IndividualsTableView) { () in
                self.aoIndividuals = Individual.getIndividuals()
                self.IndividualsTableView.reloadData()
                self.title = self.aoIndividuals[1].firstName
            print(self.aoIndividuals.count)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aoIndividuals.count
    }
    
}

