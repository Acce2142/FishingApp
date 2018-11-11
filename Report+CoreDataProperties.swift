//
//  Report+CoreDataProperties.swift
//  FishProduct
//
//  Created by ohashi on 2018/11/11.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//
//

import Foundation
import CoreData


extension Report {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Report> {
        return NSFetchRequest<Report>(entityName: "Report")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var lon: String?
    @NSManaged public var lat: String?

}
