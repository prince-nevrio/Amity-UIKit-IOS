//
//  AmityNetwork.swift
//  AmityUIKit
//
//  Created by Prince Saini on 08/02/24.
//  Copyright © 2024 Amity. All rights reserved.
//

import UIKit
import Alamofire

public class AmityNetwork {
    
    public static var baseUrl = "" // live
    static let shouldMockAPI = false
    public static let session = AmityNetwork()
    var currentDownloadRequest: DownloadRequest?
    
    func request<T: Decodable>(method: HTTPMethod, urlPath: String, type: T.Type = T.self ,headers: [String:String]? = nil, queryParams:[String:Any]? = nil, bodyParams:[String: Any]? = nil, options:[String:Any]? = nil, onCompletion:((Result<T?,Error>)->Void)? = nil) {
        
        if (!(NetworkReachabilityManager()?.isReachable ?? false)) {
            onCompletion?(.failure(NetworkError.internetNotReachable))
            return
        }
        
        var urlPath = (urlPath.contains("http") ? "" : AmityNetwork.baseUrl) + urlPath
        if let queryParams = queryParams, queryParams.count > 0 {
            urlPath = urlPath + "?" + queryParams.queryString
        }
        
        guard let fullUrl = URL(string: urlPath) else {
            onCompletion?(.failure(NetworkError.notAUrl(url: urlPath)))
            return
        }
        
        print("=====================> NetworkRequestStart \(Date()) URL:\(urlPath)")
        let headers = self.headers(customHeaders: headers)
        print("Header Parms ::: \(String(describing: headers))")
        print("Body Parms ::: \(String(describing: bodyParams))")
        AF.request(fullUrl, method: method, parameters: bodyParams, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print("=====================> NetworkRequestEnd \(Date()) URL:\(String(describing: response.request?.url?.absoluteURL))")
            if (response.response?.statusCode != 200) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                        print(json)
                    }
                    
                    let apiError = try JSONDecoder().decode(APIError.self, from: response.data!)
                    if response.request?.url?.absoluteString.contains("reset") ?? false || response.request?.url?.absoluteString.contains("password/verify") ?? false || response.request?.url?.absoluteString.contains("employee/signup") ?? false {
                        if response.response?.statusCode == 401 {
                            onCompletion?(.failure(NetworkError.alreadyUsed))
                        }else if response.response?.statusCode == 400 {
                            onCompletion?(.failure(NetworkError.alreadyUsed))
                        }
                        else if response.response?.statusCode == 498 {
                            onCompletion?(.failure(NetworkError.tokenExpired))
                        } else {
                            onCompletion?(.failure(NetworkError.apiError(message: apiError.message)))
                        }
                    } else {
                        onCompletion?(.failure(NetworkError.apiError(message: apiError.message)))
                    }
                } catch {
                    onCompletion?(.failure(error))
                    print("Error: \(error)")
                }
                
            } else {
                do {
//                    if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
//                        print(json)
//                    }
                    print("Http Response : \(response)")
                    if(response.data == nil){
                        return
                    }
                    let result = try JSONDecoder().decode(T.self, from: response.data!)
                    onCompletion?(.success(result))
                    return
                } catch {
                    onCompletion?(.failure(error))
                    print("Error: \(error)")
                }
            }
        })
    }
    
    func headers(customHeaders: [String:String]?) -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        headers["device-id"] = UUID().uuidString
        
//        if let token = PTUserDefaults.standard.authenticationData?.accessToken {
//            //Check to handle cases where we don't need to send the token even if token is present like anonymous feedback
//            if headers["Authorization"] != "" {
//                headers["Authorization"] = "Bearer \(token)"
//            }
//        }
        
        if let customHeaders = customHeaders {
            for key in customHeaders.keys {
                headers.add(HTTPHeader(name: key, value: customHeaders[key]!))
            }
        }
        return headers
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
  
}

enum NetworkError: Error, Equatable {
    case notAUrl(url: String)
    case internetNotReachable
    case apiError(message: String?)
    case invalidResetToken
    case alreadyUsed
    case tokenExpired
    
    func localizedDescription() -> String {
        switch self {
        case .notAUrl(let url):
            return "Not a valid url => \(url). Please provide a valid url."
        case .internetNotReachable:
            return "Internet not reachable"
        case .apiError(let message):
            return message ?? "Unknown Error"
        case .invalidResetToken:
            return "Invalid Reset Token"
        case .alreadyUsed:
            return "Already Used Token"
        case .tokenExpired:
            return "Reset Token Expired"
        }
    }
}

class Connectivity {
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
 
extension Dictionary {
   var queryString: String {
      var output: String = ""
      for (key,value) in self {
          output +=  "\(key)=\(value)&"
      }
      output = String(output.dropLast())
      return output
   }
}

class APIError: Codable {
    var status: Bool?
    var message: String?
}

