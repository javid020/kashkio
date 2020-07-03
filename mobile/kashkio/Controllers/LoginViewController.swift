//
//  LoginViewController.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit
import Alamofire
import JMMaskTextField_Swift

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var phoneTextField: JMMaskTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButtonX!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func login() {
//        struct Login: Encodable {
//            let email: String
//            let password: String
//        }
//
//        let login = Login(email: "test@test.test", password: "testPassword")
//
//        AF.request("https://httpbin.org/post", method: .post, parameters: login, encoder: JSONParameterEncoder.default).response { response in
//
//            debugPrint(response)
//        }
        
//        phoneTextField.text passwordTextField.text
        let user = User(id: nil, login: "+994502100080", password: "123456", nickname: nil, latitude: nil, longitude: nil, points: nil, badge: nil)
        
        /*
         success({
             message = "User retrieved successfully";
             result =     {
                 badge = "\U015e\U0259ffaf su damc\U0131s\U0131";
                 id = 1;
                 latitude = 0;
                 login = "+994502100080";
                 longitude = 0;
                 nickname = Jamal;
                 points = 0;
             };
         })
         */
        
        NetworkManager.shared.login(user) { result in
            switch result {
            
            case .success(let user):
                print(user)
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "init")

                let sceneDelegate = self.view.window?.windowScene
                sceneDelegate?.windows.first?.rootViewController = vc
                
//                UserDefaults.standard.setValue("firstTime", forKey: false)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func validate() {
        if (phoneTextField.text?.isEmpty ?? true) || (passwordTextField.text?.isEmpty ?? true) {
            
            loginButton.alpha  = 0.5
            loginButton.isEnabled = false
            
        } else {
            
            loginButton.alpha  = 1.0
            loginButton.isEnabled = true
        }
    }
    

}

extension LoginViewController: UITextFieldDelegate {
   
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        validate()
    }
}

