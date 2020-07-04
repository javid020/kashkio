////
////  ImagePost.swift
////  test
////
////  Created by Javid Abbasov on 04.07.2020.
////  Copyright © 2020 Javid Abbasov. All rights reserved.
////
//
//import Alamofire
//import SwiftyJSON
//
//class ImagePost {
//    
//    static let getTokenURL = "http://localhost:3000/v1/get_signed_url"
//    
//    private static func performUpload(image: UIImage, postURL: String, getURL: String, completionHandler: (success:Bool, getURL:String?) -> ()) {
//        if let imageData = UIImageJPEGRepresentation(image, 0.1) { // 0.1 for high compression
//            print("Uploading! Hang in there...")
//            let request = Alamofire.upload(.PUT, postURL, headers: ["Content-Type":"image/jpeg"], data:imageData)
//            request.validate()
//            request.response { (req, res, json, err) in
//                if err != nil {
//                    print("ERR \(err)")
//                    // dispatch compltionHandler to main thread (background processes
//                    // should never manipulate the UI, and completionHandler will
//                    // probably include a segue, or something)
//                    dispatch_async(dispatch_get_main_queue(), {
//                        completionHandler(success:false, getURL: getURL)
//                    })
//                } else {
//                    dispatch_async(dispatch_get_main_queue(), {
//                        completionHandler(success:true, getURL: getURL)
//                    })
//                }
//            }
//        }
//        
//    }
//    
//    static func uploadImage(image: UIImage, completionHandler: (success:Bool, getURL: String?) -> ()) {
//        let request = Alamofire.request(.GET, ImagePost.getTokenURL, encoding: .JSON)
//        request.validate()
//        request.responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    if let postURL = json["postURL"].string, getURL = json["getURL"].string {
//                        print(postURL)
//                        performUpload(image, postURL: postURL, getURL: getURL, completionHandler: completionHandler)
//                        return
//                    }
//                }
//                completionHandler(success: false, getURL: nil)
//            case .Failure (let error):
//                print("ERR \(response) \(error)")
//                completionHandler(success: false, getURL: nil)
//            }
//        }
//    }
//}
