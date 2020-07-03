//
//  RegistrationViewController.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var password1TextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButtonX!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func registerPressed() {
        
        
        var phone = phoneTextField.text
    
        phone = phone?.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range:nil)
        phone = phone?.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range:nil)
        phone = phone?.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range:nil)


        
        let user = User(id: nil, login: phone, password: password2TextField.text, nickname: fullnameTextField.text, latitude: nil, longitude: nil, points: nil, badge: nil)
        
        
        
        NetworkManager.shared.newUser(user) { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    @IBAction func imageSelectionPressed() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Button capture")
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = .photoLibrary
            imag.allowsEditing = true

            self.present(imag, animated: true, completion: nil)
        }
    }
    
    
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        
        // image
        profileImageButton.setBackgroundImage(image, for: .normal)
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func validate() {
        if (fullnameTextField.text?.isEmpty ?? true) || (phoneTextField.text?.isEmpty ?? true) || (password1TextField.text?.isEmpty ?? true) || (password2TextField.text?.isEmpty ?? true) {
            
            registerButton.alpha  = 0.5
            registerButton.isEnabled = false
            
        } else {
            
            registerButton.alpha  = 1.0
            registerButton.isEnabled = true
        }
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
   
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        validate()
    }
}
