//
//  Employee+CoreDataProperties.swift
//  EmployeeManagement
//
//  Created by shivam kumar on 13/09/21.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var department: String?
    @NSManaged public var empId: String?
    @NSManaged public var mobileNo: String?
    @NSManaged public var name: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var salary: String?

}

extension Employee : Identifiable {

}
