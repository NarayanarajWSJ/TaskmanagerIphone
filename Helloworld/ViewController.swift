

import UIKit




class ViewController: UIViewController {

    var response1: Int = 0;
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBAction func buttonClicked(_ sender: UIButton) {

        
        if let buttonTitle = sender.title(for: .normal) {
            print(buttonTitle)
//            label.text = buttonTitle
            if buttonTitle == "Login"{
                
                if usernameTxt.text!.isEmpty ||
                    passwordTxt.text!.isEmpty
                {
                    displayAlertMessage(message: "Please fill all the fields");
                    return;
                }
                
                print("login action to be performaed")
                let loginURL = "https://taskrapi.herokuapp.com/api/taskusers/login";
                let loginParams:[String:String] = ["username": usernameTxt.text!,"password":passwordTxt.text!]
                let res = postLoginCall(url : loginURL,paramsDictionary : loginParams);
                
                print(res)
                let resultFail = "Login Failed"
                print("res - " + res)
                if res == resultFail  {
                    print(res)
                    displayAlertMessage(message: "Invaild login input");
                    self.usernameTxt.text = ""
                    self.passwordTxt.text = ""
                    return;
                }
                
                
            }
//            else if(buttonTitle == "Register"){
////                print("username = "+ usernameTxt.text + ": Password = " + passwordTxt.text)
//                usernameTxt.text = ""
//                passwordTxt.text = ""
//            
//            }
            
        }else{
            print("button clicked")
        }
    }
    
    // Function to call Login
    
    func postLoginCall(url : String,paramsDictionary : [String:String]) -> String{
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
//        let isUsername = NSRange textRange =[paramsDictionary["username"] rangeOfString:@"@"];

        var postString : String = ""
        if paramsDictionary["username"]!.range(of:".com") != nil {
            postString = "email=\( paramsDictionary["username"]!)&password=\( paramsDictionary["password"]!)"
        }else{
            postString = "username=\( paramsDictionary["username"]!)&password=\( paramsDictionary["password"]!)"
        }
        
        
//        print(postString)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        var result = "";
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
//                        self.displayAlertMessage(message: "Login Failed");
//                        self.usernameTxt.text = ""
//                        self.passwordTxt.text = ""
                        result = "Login Failed"
                        return
                    }else{
                        print(responseJSON["id"]!)
                        print("Login Successful")
                        result = "Login Successful"
                        return
//                        let vc = MainViewController()
//                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
//                    self.response1 = responseJSON["status"]! as! Int
//                    print(self.response1)
                    //Check response from the sever
//                    if self.response1 == 200
//                    {
//                        OperationQueue.main.addOperation {
//                            //API call Successful and can perform other operatios
//                            
//                        }
//                    }
//                    else
//                    {
//                        OperationQueue.main.addOperation {
//                            //API call failed and perform other operations
//                            
//                        }
//                    }
                }
            }
            catch {
                print("Error -> \(error)")
            }
        }
        print("1")
        task.resume()
        while result.isEmpty {
        }
        print("2")
        return result
    }
    func displayAlertMessage(message:String){
        let myAlert = UIAlertController(title: "Task Manager", message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }

}

