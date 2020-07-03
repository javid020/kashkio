//
//  NetworkManager.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020.
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import Foundation
import Alamofire


enum NetworkErrors: Error {
    case invalidCredentials, incorrectFormat, default2
}


struct ResponseUser: Codable {
    var message: String?
    var result: User?
}

class NetworkManager {
    
    private init() {
        
    }
    
    static var shared: NetworkManager = NetworkManager()
    
    private let baseUrl = "http://3.22.185.245:8080/"
    
    private func completeUrl(_ key:String) -> String {
        return baseUrl + key;
    }
    
    /*
     Result:
     Success: Success
     Fail: User already exists
     */
    ///  Create a new user:
    func newUser(_ user: User, completed: @escaping (Result<[String], Error>) -> Void) {
        
        print(user)
        
        let p: [String: String] = [
            "login": user.login!,
            "password": user.password!,
            "nickname": user.nickname!
        ]
        
        AF.request(completeUrl("user/register"), method: .post, parameters: p, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseString { response in
            
            print(response)
            
//            if let result = response.value {
//                let JSON = result as! NSDictionary
//
//                switch JSON["message"] as! String {
//                case "User retrieved successfully":
//                    // go on
//                    print("salam")
//
//                    let decoder = JSONDecoder()
//
//                    do {
//                        let data = try NSKeyedArchiver.archivedData(withRootObject: JSON["result"] ?? "", requiringSecureCoding: false)
//                        let user = try decoder.decode(User.self, from: data)
//                        print(user)
//                        completed(.success(user))
//                    } catch {
//                        print(error.localizedDescription)
//                        completed(.failure(.default2))
//                    }
//
//                default:
//                    completed(.failure(.default2))
//                }
//            }
            
            
        }
    }
    
    
    
    
    func login(_ user: User, completed: @escaping (Result<User, NetworkErrors>) -> Void) {
        
        AF.request(completeUrl("user/login"), method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseJSON { response in
            
            print(response)
            
            do {
                let decoder = JSONDecoder()
                let responseUser = try decoder.decode(ResponseUser.self, from: response.data!)
                completed(.success(responseUser.result!))
            } catch {
                print(error)
                completed(.failure(.default2))
            }
        }
    }
    
    func updateUserDetails(_ user: User, completed: @escaping (Result<[String], Error>) -> Void) {
        
        AF.request(completeUrl("user/update"), method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseJSON { response in
            
            
        }
    }
    
    // Rating tab
    func getUserDetails(_ user: User, completed: @escaping (Result<[String], Error>) -> Void) {
        
        AF.request(completeUrl("user/\(user.id!)"), method: .get, parameters: ["":""], encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseJSON { response in
            
            
            let statusCode = response.response?.statusCode
            
        }
    }
    
    
    //MARK:- WATER REQUESTS
    
    func addWaterRequest(_ waterRequest: WaterRequest, completed: @escaping (Result<[String], Error>) -> Void) {
        
        AF.request(completeUrl("request/add"), method: .post, parameters: waterRequest, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseJSON { response in
            
            
            let statusCode = response.response?.statusCode
            
            
        }
    }
    
    
    /*
     get open water requests in given radius:  
     GET http://host:port/request/open/{userId}/{radiusInMeters} //default 500m radius
     
     */
    
    func getWaterRequests(userID: Int, radius: Int = 500, completed: @escaping (Result<[String], Error>) -> Void) {
        
        AF.request(completeUrl("request/open/\(userID)/\(radius)")).responseJSON { response in
            print(response)
        }
        
    }
    
    
    func closeWaterRequests(waterRequestID: Int, completed: @escaping (Result<[String], Error>) -> Void) {
        
        
        AF.request(completeUrl("request/close/\(waterRequestID)"), method: .post, parameters: ["":""], encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseJSON { response in
            
            
            let statusCode = response.response?.statusCode
            
        
        }
    }
    
    func applyForHelp(waterRequestID: Int, userID: Int, completed: @escaping (Result<[String], Error>) -> Void) {
        
        let p: [String : [String: Int]] = [
            "waterRequest": ["id": waterRequestID],
            "appliedUser": ["id": userID]
        ]
        
        AF.request(completeUrl("request/apply"), method: .post, parameters: p, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseJSON { response in
            
            
            let statusCode = response.response?.statusCode
            
            
            
        }
    }
    
    
    func getListOfAppliedUsers(waterRequestID: Int, completed: @escaping (Result<[String], Error>) -> Void) {
        AF.request(completeUrl("request/applied/\(waterRequestID)"), method: .post, parameters: ["":""], encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseJSON { response in
            
            
            print(response)
            
            
        }
    }
    
    func updateStatusOfWaterRequest(user: User, status: String, completed: @escaping (Result<[String], Error>) -> Void) {
        
        let parameters: [String: Any] = [
            "id": user.id!,
            "status": status
        ]
        
        var request = URLRequest(url: URL(string: completeUrl("request/update"))!)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
        
    }
    
    
    
}

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
