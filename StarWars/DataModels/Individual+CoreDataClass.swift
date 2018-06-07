//
//  Individual+CoreDataClass.swift
//  StarWars
//
//  Created by Tanner Morse on 6/5/18.
//  Copyright © 2018 Tanner Morse. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Individual)
public class Individual: NSManagedObject {
    
    class func addIndividual(firstName: String, lastName: String, id: Int32, profilePicture: NSData, birthdate: String, forceSensitive: Bool, affiliation: String, cntx: NSManagedObjectContext) {
        
        let newIndividual = NSEntityDescription.insertNewObject(forEntityName: "Individual", into: cntx) as! Individual
        newIndividual.firstName = firstName
        newIndividual.lastName = lastName
        newIndividual.id = id
        newIndividual.profilePicture = profilePicture
        newIndividual.affiliation = affiliation
        newIndividual.birthdate = birthdate
        newIndividual.forceSensitive = forceSensitive
    }
    
    class func parseArticle(tableView: UITableView, completion: @escaping () -> Void) {
        self.fetchAndDelete()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let cntx = appDelegate.persistentContainer.viewContext
        let url = URL(string: "https://starwarstest16.herokuapp.com/api/characters")!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: .mutableContainers) as? [String: Any] {
                            if let aoIndividuals = jsonResult["individuals"] as? [[String:Any]] {
                                for individual in aoIndividuals {
                                        let imageURL = individual["profilePicture"] as! String
                                        let url = URL(string: imageURL)
                                        if url != nil {
                                            let imageData = NSData(contentsOf: url!)
                                            let force = (individual["forceSensitive"] as? Bool)!
                                            self.addIndividual(firstName: individual["firstName"] as! String, lastName: individual["lastName"] as! String, id: individual["id"] as! Int32, profilePicture: imageData!, birthdate: individual["birthdate"] as! String, forceSensitive: force, affiliation: individual["affiliation"] as! String, cntx: cntx)
                                            appDelegate.saveContext()
                                            UserDefaults.standard.set(1, forKey: "hasData")
                                        }
                                }
                            }
                            completion()
                        }
                    } catch {
                        print("json serialization failed")
                    }
                }
            }
        }
        task.resume()        
    }
    
    class func getIndividuals() -> [Individual] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Individual")
        let cntx = appDelegate.persistentContainer.viewContext
        var individuals = [Individual]()
        do {
            try individuals = cntx.fetch(request) as! [Individual]
        } catch {
            print("fetch Reaquest failed")
        }
        return individuals
    }
    
    class func fetchAndDelete() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Individual")
        let cntx = appDelegate.persistentContainer.viewContext
        var individuals = [Individual]()
        
        do {
            try individuals = cntx.fetch(request) as! [Individual]
            for item in individuals {
                cntx.delete(item)
            }
        } catch {
            print("Fetch request failed")
        }
        if cntx.hasChanges {
            do {
                try cntx.save()
            } catch {
                print("save failed")
            }
        }
    }

}

extension Individual {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Individual> {
        return NSFetchRequest<Individual>(entityName: "Individual")
    }
    @NSManaged public var id: Int32
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var birthdate: String?
    @NSManaged public var profilePicture: NSData?
    @NSManaged public var forceSensitive: Bool
    @NSManaged public var affiliation: String?
    
}


