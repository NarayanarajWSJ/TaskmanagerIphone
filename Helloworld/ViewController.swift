

import UIKit

struct apiURL{
    static let loginURL = "https://taskrapi.herokuapp.com/api/taskusers/login";
    
    static func postCall(url : String,paramsDictionary : [String:String]) -> [String:AnyObject] {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        var postString : String = ""
        for item in paramsDictionary {
            print(item.key + " == " + item.value)
            postString += item.key + "=" + item.value + "&"
        }
        print(postString)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        var result :[String:AnyObject] = [:];
        let group = DispatchGroup()
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                result["error"] = String(describing: error) as AnyObject
                group.leave()
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    result = responseJSON
                     group.leave()
                }
            }
            catch {
                print("Error -> \(error)")
                result["error"] = String(describing : error) as AnyObject
                group.leave()
                return
            }
        }
        group.enter()
        task.resume()
        group.wait()
        
        return result
    }
    
}
struct loggerUser {
    static var accessId = ""
    static var userId = 0
}


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
                
                var loginParams:[String:String] = ["email": usernameTxt.text!,"password":passwordTxt.text!]
                
                if !usernameTxt.text!.contains("@") {
                    loginParams.removeValue(forKey: "email")
                    loginParams["username"] = usernameTxt.text!
                }
//
                let res1 = apiURL.postCall(url :apiURL.loginURL,paramsDictionary : loginParams)
                print("res1 : ")
                for item in res1 {
//                    if(item.value.isKind(of:) )
//
//                    else if(item.value.isKind(of: Int) ){
//                        print(item.key + " - " + String(item.value as! Int))
//                    }
                    print(item.key)
                    print(item.value)
                    print("-----")
                }
                print("Completed")
                let res = postLoginCall(url : apiURL.loginURL,paramsDictionary : loginParams);

                
                
                print(res)
                let resultFail = "Login Failed"
                print("res - " + res)
                if res == resultFail  {
                    print(res)
                    displayAlertMessage(message: "Invaild login input");
                    self.usernameTxt.text = ""
                    self.passwordTxt.text = ""
                    return;
                }else if res.starts(with: "error"){
                    print(res)
                    displayAlertMessage(message: "Service Down. Please try after some time");
                    self.usernameTxt.text = ""
                    self.passwordTxt.text = ""
                    return;
                }
                
                
            }
        }else{
            print("button clicked")
        }
        print("fasd")
    }
    
    // Function to call Login
    
    func postLoginCall(url : String,paramsDictionary : [String:String]) -> String {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        var postString : String = ""
        for item in paramsDictionary {
            print(item.key + " == " + item.value)
            postString += item.key + "=" + item.value + "&"
        }
        print(postString)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        var result = "";
        let group = DispatchGroup()
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                result = "error=\(String(describing: error))"
                group.leave()
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
                result = "error=\(error))"
                group.leave()
                return
            }
        }
       group.enter()
        task.resume()
       group.wait()

        return result
    }
    func displayAlertMessage(message:String){
        let myAlert = UIAlertController(title: "Task Manager", message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }

}

