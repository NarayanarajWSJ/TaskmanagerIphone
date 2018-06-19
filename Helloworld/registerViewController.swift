//
//  registerViewController.swift
//  Helloworld
//
//  Created by Narayanaraj on 15/06/18.
//  Copyright © 2018 Narayanaraj. All rights reserved.
//

import UIKit

class registerViewController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnRegisterClick(_ sender: Any) {
        let usrFirstName = txtFirstName.text
        let usrLastName = txtlastname.text
        let usrEmail = txtEmail.text
        let usrPwd = txtPassword.text
        let usrRePwd = txtRePassword.text
        
        if usrFirstName!.isEmpty ||
            usrLastName!.isEmpty ||
            usrEmail!.isEmpty ||
            usrPwd!.isEmpty ||
            usrRePwd!.isEmpty
        {
            displayAlertMessage(message: "Please fill all the fields");
            return;
        }
        if usrPwd != usrRePwd {
            displayAlertMessage(message: "Password Does not match");
            txtPassword.text = ""
            txtRePassword.text = ""
            return;
        }
        
    }
    func displayAlertMessage(message:String){
        let myAlert = UIAlertController(title: "Task Manager", message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
}
