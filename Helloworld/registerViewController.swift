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
    
    @IBOutlet weak var txtusername: UITextField!
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
    
    func postRegisterCall(url : String,paramsDictionary : [String:String]) -> String {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        var postString : String = ""
        if paramsDictionary["username"]!.range(of:".com") != nil {
            postString = "email=\( paramsDictionary["username"]!)&password=\( paramsDictionary["password"]!)"
        }else{
            postString = "username=\( paramsDictionary["username"]!)&password=\( paramsDictionary["password"]!)"
        }
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        var result = "";
        let group = DispatchGroup()
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    //                    print(responseJSON)
                    if responseJSON["error"] != nil{
                        print(responseJSON["error"]!)
                        print("Login Failed")
                        result = "Login Failed"
                        group.leave()
                        return
                    }else{
                        print(responseJSON["id"]!)
                        print("Login Successful")
                        result = "Login Successful"
                        //                        completion(true)
                        loggerUser.accessId = responseJSON["id"] as! String
                        loggerUser.userId = responseJSON["userId"] as! Int
                        group.leave()
                        return
                    }
                }
            }
            catch {
                print("Error -> \(error)")
            }
        }
        group.enter()
        task.resume()
        group.wait()
        
        return result
    }
    
}
