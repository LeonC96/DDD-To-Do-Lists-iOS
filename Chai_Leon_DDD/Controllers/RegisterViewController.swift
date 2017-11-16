//
//  RegisterViewController.swift
//  Chai_Leon_DDD
//
//  Created by Leon Chai on 2017-11-16.
//  Copyright © 2017 Leon Chai. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

	@IBOutlet weak var usernameTxtField: UITextField!
	@IBOutlet weak var emailTxtField: UITextField!
	@IBOutlet weak var passwordTxtField: UITextField!
	@IBOutlet weak var confirmPasswordTxtField: UITextField!
	@IBOutlet weak var messageLbl: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func signup(_ sender: UIButton) {
		SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
		SVProgressHUD.show()
		
		let email = emailTxtField.text
		let password = passwordTxtField.text
		
		Auth.auth().createUser(withEmail: email!, password: password!) { (user,error) in
			if(email! == ""){
				self.messageLbl.text = "Enter An Email!"
				self.messageLbl.sizeToFit()
				self.messageLbl.center.x = self.view.center.x
				SVProgressHUD.dismiss()
				return
			}
			
			if error != nil {
				if(!self.checkPassword(password: password!)){
					self.messageLbl.text = "Password Too Short!"
				} else {
					self.messageLbl.text = "Email Already Exist!"
					
				}
				self.messageLbl.sizeToFit()
				self.messageLbl.center.x = self.view.center.x
				SVProgressHUD.dismiss()
				return
			}
			
			self.messageLbl.text = "Registered!"
			self.messageLbl.sizeToFit()
			self.messageLbl.center.x = self.view.center.x
			print(email! + " has been registered")
			FirebaseDB.createNewUserTable()
			
			SVProgressHUD.dismiss()
			self.performSegue(withIdentifier: "startSegue", sender: self)
			
			
		}
	}
	
	private func checkPassword(password: String) -> Bool{
		if(password.count <= 5) {
			return false
		}
		return true
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}