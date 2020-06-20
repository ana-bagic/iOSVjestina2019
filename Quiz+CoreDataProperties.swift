//
//  Quiz+CoreDataProperties.swift
//  QuizAppFinal
//
//  Created by five on 20/06/2020.
//  Copyright © 2020 five. All rights reserved.
//
//

import Foundation
import CoreData

extension Quiz {

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var level: Int16
    @NSManaged public var image: String?
    @NSManaged public var category: String?
    @NSManaged public var questions: NSSet?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }
    
}

extension Quiz {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
