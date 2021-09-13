//
//  TableViewCell.swift
//  EmployeeMangementSystemAssignment
//
//  Created by shivam kumar on 09/09/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var phoneNumberLabel : UILabel!
    @IBOutlet weak var departmentLabel : UILabel!
    @IBOutlet weak var salaryLabel : UILabel!
    @IBOutlet weak var employeeNumber : UILabel!
    @IBOutlet weak var profileImage : UIImageView!
    
    private var data1 = Employee()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        nameLabel.layer.cornerRadius = 10
        nameLabel.layer.masksToBounds = true
        phoneNumberLabel.layer.cornerRadius = 10
        departmentLabel.layer.cornerRadius = 10
        salaryLabel.layer.cornerRadius = 10
        phoneNumberLabel.layer.masksToBounds = true
        departmentLabel.layer.masksToBounds = true
        salaryLabel.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 40
    }
    
    func injectDependencies(data : Employee?) {
        guard let data1 = data else{
            return
        }
        print(data1,"image checkinh")
        employeeNumber.text = data1.empId
        nameLabel.text = "    \(data1.name ?? "" )"
        departmentLabel.text = "    \(data1.department ?? "" )"
        salaryLabel.text = "    \(data1.salary ?? "")"
        phoneNumberLabel.text = "    \(data1.mobileNo ?? "")"
        if data1.profileImage != nil {
            profileImage.image = UIImage(data: data1.profileImage!)
        }
    }
}



