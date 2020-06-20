//
//  Answer+CoreDataProperties.swift
//  QuizAppFinal
//
//  Created by five on 20/06/2020.
//  Copyright © 2020 five. All rights reserved.
//
//

import Foundation
import CoreData

extension Answer {

    @NSManaged public var a: String?
    @NSManaged public var b: String?
    @NSManaged public var c: String?
    @NSManaged public var d: String?
    @NSManaged public var toQuestion: Question?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }
    
}
