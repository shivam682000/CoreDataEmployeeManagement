//
//  ViewController.swift
//  EmployeeMangementSystemAssignment
//
//  Created by shivam kumar on 08/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var tableView : UITableView!
    var employee = [Employee]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view Did load")
        self.employee = Database.shareInstance.getEmployeeData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEmpBtnTapped))
    }
    
    @objc func addEmpBtnTapped() {
        print("hello shivam here")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: ADDUSERVIEWCONTROLLER) as! AddUserViewController
        secondViewController.delegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employee.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL, for: indexPath) as! TableViewCell
        cell.injectDependencies(data: employee[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            employee = Database.shareInstance.deleteData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: EDIT, message: DO_YOU_WANT_TO_EDIT, preferredStyle: .alert)
        let okAction = UIAlertAction(title: OK, style: UIAlertAction.Style.default) {
                UIAlertAction in
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: ADDUSERVIEWCONTROLLER) as! AddUserViewController
            secondViewController.editInformation(object: self.employee[indexPath.row])
            secondViewController.i = indexPath.row
            secondViewController.isUpdate = true
            secondViewController.delegate = self
            self.navigationController?.pushViewController(secondViewController, animated: true)
            }
        let cancelAction = UIAlertAction(title: CANCEL, style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                print("Cancel Pressed")
            }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController : UserDelegate {
    func transfer() {
        DispatchQueue.main.async {
            print("editInformation")
            self.employee = Database.shareInstance.getEmployeeData()
            self.tableView.reloadData()
     }
  }
}

