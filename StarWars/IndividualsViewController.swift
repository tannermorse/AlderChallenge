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
        self.IndividualsTableView.isHidden = true
        self.syncAlertHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.integer(forKey: "hasData") != 0 {
            self.title = "Balancers of the Force"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualTableViewCell", for: indexPath) as! IndividualTableViewCell
        cell.renderCell(individual: aoIndividuals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flowdelegate?.PushIndividualProfile(individual: aoIndividuals[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aoIndividuals.count
    }
    
    func syncAlertHandler() {
        let alert = self.setupAlert()
        if UserDefaults.standard.integer(forKey: "hasData") == 0 {
            self.present(alert, animated: true, completion: {
                self.loadAndPresentData(alert: alert)
            })
        } else {
            self.setupViewcontroller()
        }
    }
    func loadAndPresentData(alert: UIAlertController) {
        Individual.parseArticle(tableView: self.IndividualsTableView) { () in
            DispatchQueue.main.async(execute: { () -> Void in
                self.setupViewcontroller()
                alert.dismiss(animated: true, completion: nil)
            })
        }
    }
    func setupViewcontroller() {
        self.aoIndividuals = Individual.getIndividuals()
        self.setupNavBar()
        self.IndividualsTableView.reloadData()
        self.IndividualsTableView.isHidden = false
    }
    
    func setupNavBar() {
        let textAttributes = [NSAttributedStringKey.font: UIFont(name: "Georgia-Bold", size: 20)!]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        self.title = "Balancers of the Force"
    }
    
    func setupAlert() -> UIAlertController {
        let title = "Downloading"
        let message = "\n\nThis may take a minute depending on your connection."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let indicatorSpacingConstant = -5
        let INDICATOR_SPACING: CGFloat = CGFloat(indicatorSpacingConstant)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: INDICATOR_SPACING, width: alert.view.frame.width, height: alert.view.frame.height))
        indicator.activityIndicatorViewStyle = .gray
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        return alert
    }
}

