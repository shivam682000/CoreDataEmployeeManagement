//
//  Database.swift
//  EmployeeManagement
//
//  Created by shivam kumar on 13/09/21.
//

//
//  Database.swift
//  EmployeeManagement
//
//  Created by shivam kumar on 11/09/21.
//

import Foundation
import CoreData
import UIKit
class Database {
    
    static var shareInstance = Database()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object:[String:String],at imageData:Data ) {
        print(getEmployeeData())
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context!) as! Employee
        
        employee.empId =  object["empId"]
        employee.name = object["name"]
        employee.salary = object["salary"]
        employee.department = object["department"]
        employee.mobileNo = object["mobileNo"]
        employee.profileImage = imageData
        
        do{
            try context?.save()
        }catch{
            print("data is not saved")
        }
        
    }
    
    func getEmployeeData() -> [Employee] {
        var employee = [Employee]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        do{
            employee = try context?.fetch(fetchRequest) as! [Employee]
        }catch{
            print("can not get Data")
        }
        return employee
    }
    
    func deleteData(index : Int) -> [Employee]{
        var employee = getEmployeeData()
        context?.delete(employee[index])
        employee.remove(at: index)
        do{
            try context?.save()
        }catch{
            print("can not delete data")
        }
        return employee
    }
    
    func update(object : [String:String],index : Int,at imageData:Data) {
        var employee = getEmployeeData()
        employee[index].profileImage = imageData
        employee[index].name = object["name"]
        employee[index].department = object["department"]
        employee[index].empId = object["empId"]
        employee[index].salary = object["salary"]
        employee[index].mobileNo = object["mobileNo"]
        do{
            try context?.save()
        }catch{
            print("data is not saved")
        }
        
    }
}

