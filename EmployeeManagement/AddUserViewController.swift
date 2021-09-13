//
//  AddUserViewController.swift
//  EmployeeManagement
//
//  Created by shivam kumar on 13/09/21.
//

//
//  AddUserViewController.swift
//  EmployeeMangementSystemAssignment
//
//  Created by shivam kumar on 09/09/21.
//

import UIKit
protocol UserDelegate {
   func transfer()
}

class AddUserViewController: UIViewController {
   
   var delegate : UserDelegate?
   var isUpdate = Bool()
   var i = Int()
   var object1 = Employee()
   var arr = [Employee]()
   
   @IBOutlet weak var profileImage : UIImageView!
   @IBOutlet weak var button : UIButton!
   @IBOutlet weak var nameTextField : UITextField!
   @IBOutlet weak var empIdTextField : UITextField!
   @IBOutlet weak var salaryTextField : UITextField!
   @IBOutlet weak var phoneTextField : UITextField!
   @IBOutlet weak var departmentTextField : UITextField!
   
   override func viewDidLoad() {
       super.viewDidLoad()
       profileImage.layer.cornerRadius = 50
       uiDesign()
       setup()
       let tap = UITapGestureRecognizer(target: self, action:  #selector(AddUserViewController.tappedMe))
               profileImage.addGestureRecognizer(tap)
       profileImage.isUserInteractionEnabled = true
   }
   
   
   @IBAction func submitInformation(_ sender: Any) {
           let png = self.profileImage.image?.pngData()
           guard let png1 = png else{
               return
           }
           let dict = ["empId":empIdTextField.text,"name":nameTextField.text,"department":departmentTextField.text,"salary":salaryTextField.text,"mobileNo":phoneTextField.text,]
           if isUpdate {
               Database.shareInstance.update(object: dict as! [String:String], index: self.i,at:png1)
           }
           else {
               
               Database.shareInstance.save(object: dict as! [String:String], at: png1)
           }
           delegate?.transfer()
           self.navigationController?.popViewController(animated: true)
       
   }
   @objc func tappedMe() {
       let ac = UIAlertController(title: SELECT, message: SELECT_IMAGE_FROM, preferredStyle: .actionSheet)
       let cameraBtn = UIAlertAction(title: CAMERA, style: .default){ (_) in
           self.showImagePicker(selectedSourceType: .camera)
           print("camera")
   }
       let libraryBtn = UIAlertAction(title: LIBRARY, style: .default){ (_) in
           self.showImagePicker(selectedSourceType: .photoLibrary)
           print("Library")

       }
      ac.addAction(cameraBtn)
       ac.addAction(libraryBtn)
      self.present(ac, animated: true, completion: nil)
  }

  func showImagePicker(selectedSourceType : UIImagePickerController.SourceType) {
      guard UIImagePickerController.isSourceTypeAvailable(selectedSourceType) else {
          print("Source type not available")
          return
      }
      let picker = UIImagePickerController()
       picker.delegate = self
      picker.sourceType = selectedSourceType
      picker.allowsEditing = true
       self.present(picker, animated: true, completion: nil)
   }

   func uiDesign() {
       nameTextField.layer.cornerRadius = 20
       empIdTextField.layer.cornerRadius = 20
       salaryTextField.layer.cornerRadius = 20
       departmentTextField.layer.cornerRadius = 20
       phoneTextField.layer.cornerRadius = 20
       button.layer.cornerRadius = 25
   }
   
   func setup() {
       if self.arr.count != 0 {
       self.empIdTextField.text = object1.empId
       self.nameTextField.text = object1.name
       self.departmentTextField.text = object1.department
       self.salaryTextField.text = object1.salary
       self.phoneTextField.text = object1.mobileNo
           if object1.profileImage != nil {
               self.profileImage.image = UIImage(data: object1.profileImage!)}
   }
  }


func editInformation(object : Employee?) {
   print(self.arr.count)
   self.object1 = object!
   self.arr.append(object1)
   print(self.arr.count)
 }
}

extension AddUserViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       if let selectedImage = info[.originalImage] as? UIImage{
           profileImage.image = selectedImage
       }
       else {
           print("not found")
       }
       picker.dismiss(animated: true, completion: nil)
   }
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       picker.dismiss(animated: true, completion: nil)
   }
}

