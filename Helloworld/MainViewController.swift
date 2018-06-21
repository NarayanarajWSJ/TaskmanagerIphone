//
//  MainViewController.swift
//  Helloworld
//
//  Created by Narayanaraj on 18/06/18.
//  Copyright © 2018 Narayanaraj. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Logged userId : " + String(loggerUser.userId) )
        print("Logged access : " + loggerUser.accessId )
        // Do any additional setup after loading the view.
        
        // Call the logger user tasks
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Logged userId" + String(loggerUser.userId) )
        print("Logged access" + loggerUser.accessId )
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        print("Logged userId" + String(loggerUser.userId) )
        print("Logged access" + loggerUser.accessId )
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sampleclocked(_ sender: Any) {
        print("Entered")
        print("Logged userId" + String(loggerUser.userId) )
        print("Logged access" + loggerUser.accessId )
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
