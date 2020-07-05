//
//  NetworkManager.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020.
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
    
    func getUserDetails(userID id: Int, completed: @escaping (Result<User, NetworkErrors>) -> Void) {
        
        AF.request(completeUrl("user/\(id)")).responseJSON { response in
            
            //            print(response)
            
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
    
    
    func getAllUsers(completed: @escaping (Result<[User], NetworkErrors>) -> Void) {
        
        AF.request(completeUrl("user/all")).responseJSON { response in
            
            //            print(response)
            
            do {
                let decoder = JSONDecoder()
                let responseUser = try decoder.decode([User].self, from: response.data!)
                completed(.success(responseUser))
            } catch {
                print(error)
                completed(.failure(.default2))
            }
            
        }
    }
    
    
    //MARK:- WATER REQUESTS
    
    func addWaterRequest(_ waterRequest: WaterRequest, completed: @escaping (Result<[String], Error>) -> Void) {
        
        AF.request(completeUrl("request/add"), method: .post, parameters: waterRequest, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseString { response in
            
            print(response)
            
        }
    }
    
    
    /*
     get open water requests in given radius:  
     GET http://host:port/request/open/{userId}/{radiusInMeters} //default 500m radius
     
     */
    
    // vsegda posilay svoy id
    func getWaterRequests(userID: Int, radius: Int = 5000000, completed: @escaping (Result<[WaterRequest], NetworkErrors>) -> Void) {
        
        AF.request(completeUrl("request/open/\(userID)/\(radius)")).responseJSON { response in
            
            print(response)
            
            do {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
                
                let decoder = JSONDecoder()
                let waterRequests = try decoder.decode([WaterRequest].self, from: response.data!)
                
                var answer: [WaterRequest] = []
                
                waterRequests.forEach { request in
                    if request.availTill == nil {
                        answer.append(request)
                    }
                }
                
                completed(.success(answer.reversed()))
            } catch {
                print(error)
                completed(.failure(.default2))
            }
        }
        
    }
    
    // available till
    func closeWaterRequests(waterRequestID: Int, completed: @escaping (Result<String, NetworkErrors>) -> Void) {
        
        
        AF.request(completeUrl("request/close/\(waterRequestID)"), method: .post, parameters: ["":""], encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseString { response in
            
            switch response.value {
            case "Success":
                completed(.success(response.value ?? "asodioigoioiasf"))
            default:
                completed(.failure(.default2))
            }
            
        }
    }
    
    func applyForHelp(waterRequestID: Int, userID: Int, completed: @escaping (Result<String, NetworkErrors>) -> Void) {
        
        let p: [String : [String: Int]] = [
            "waterRequest": ["id": waterRequestID],
            "appliedUser": ["id": userID]
        ]
        
        AF.request(completeUrl("request/apply"), method: .post, parameters: p, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseString { response in
            
            switch response.value {
            case "Success":
                completed(.success(response.value ?? "asodioigoioiasf"))
            default:
                completed(.failure(.default2))
            }
            
            
            
        }
    }
    
    func getListOfAppliedUsers(waterRequestID: Int, completed: @escaping (Result<[AppliedUser], NetworkErrors>) -> Void) {
        AF.request(completeUrl("request/applied/\(waterRequestID)")).responseJSON { response in
            print("GET LIST OF APPLIED USERS")
            print(response)
            //            print()
            
            do {
                let decoder = JSONDecoder()
                let responseUsers = try decoder.decode([AppliedUser].self, from: response.data!)
                completed(.success(responseUsers.filter { $0.status == "OPEN" } ))
            } catch {
                print(error)
                completed(.failure(.default2))
            }
        }
    }
    
    func updateStatusOfWaterRequest(waterRequestID id: Int, status: String, completed: @escaping (Result<String, NetworkErrors>) -> Void) {
        
        let p: [String : String] = [
            "id": "\(id)",
            "status": status
        ]
        
        AF.request(completeUrl("request/update"), method: .post, parameters: p, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: .none).responseString { response in
            
            switch response.value {
            case "Success":
                completed(.success(response.value ?? "asodioigoioiasf"))
            default:
                completed(.failure(.default2))
            }   
        }
    }
    
    func sendImage(_ image: UIImage, completed: @escaping (Result<String, NetworkErrors>) -> Void) {

        guard let data = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        
    }
    
    
}

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
