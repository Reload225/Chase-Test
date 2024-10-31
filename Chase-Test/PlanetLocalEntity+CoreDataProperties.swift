//
//  PlanetLocalEntity+CoreDataProperties.swift
//  Chase-Test
//
//  Created by Shamil Imanov on 30.10.2024.
//
//

import Foundation
import CoreData


extension PlanetLocalEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetLocalEntity> {
        return NSFetchRequest<PlanetLocalEntity>(entityName: "PlanetLocalEntity")
    }

    @NSManaged public var population: String?
    @NSManaged public var name: String?
    @NSManaged public var climate: String?
    @NSManaged public var terrain: String?

}

extension PlanetLocalEntity: Identifiable {}
