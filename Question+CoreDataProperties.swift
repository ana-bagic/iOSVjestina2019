//
//  Question+CoreDataProperties.swift
//  QuizAppFinal
//
//  Created by five on 20/06/2020.
//  Copyright © 2020 five. All rights reserved.
//
//

import Foundation
import CoreData

extension Question {

    @NSManaged public var id: Int
    @NSManaged public var question: String
    @NSManaged public var correct_answer: Int
    @NSManaged public var inQuiz: Quiz
    @NSManaged public var a: String
    @NSManaged public var b: String
    @NSManaged public var c: String
    @NSManaged public var d: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

}
