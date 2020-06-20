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

    @NSManaged public var id: Int32
    @NSManaged public var question: String?
    @NSManaged public var correct_answer: Int16
    @NSManaged public var inQuiz: Quiz?
    @NSManaged public var answers: NSSet?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

}

extension Question {

    @objc(addAnswersObject:)
    @NSManaged public func addToAnswers(_ value: Answer)

    @objc(removeAnswersObject:)
    @NSManaged public func removeFromAnswers(_ value: Answer)

    @objc(addAnswers:)
    @NSManaged public func addToAnswers(_ values: NSSet)

    @objc(removeAnswers:)
    @NSManaged public func removeFromAnswers(_ values: NSSet)

}
