//
//  Individual+CoreDataProperties.swift
//  StarWars
//
//  Created by Tanner Morse on 6/5/18.
//  Copyright © 2018 Tanner Morse. All rights reserved.
//
//

import Foundation
import CoreData


extension Individual {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Individual> {
        return NSFetchRequest<Individual>(entityName: "Individual")
    }

    @NSManaged public var id: Int32
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var birthdate: NSDate?
    @NSManaged public var profilePicture: NSData?
    @NSManaged public var forceSensitive: Bool
    @NSManaged public var affiliation: String?

}
