//
//  WebServiceManger.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import Foundation

enum SiddError: Error {
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsuppotedURL
}

enum HttpMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

class RestWebServices{
    
    static let sharedInstance = RestWebServices()
    
    func getCurrentWeatherData(fromURL url: String,
                        withHttpMethod httpMethod: HttpMethod,
                        requestType type:String,
                        deviceLat lat:String,
                        deviceLong long:String,
                        deviceToken devtoken:String,
                        units:String,
                        onSuccess: @escaping(CurrentWeather) -> Void,
                        onFailure: @escaping(Error) -> Void){
         
        let requestFinalUrl:String = url + type + "access_key=" + devtoken + "&query=" + lat + "," + long + "&units=" + units
        print(requestFinalUrl)
        var request = URLRequest(url: URL(string:requestFinalUrl )!)
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let error = error {
                //print ("error: \(error)")
                onFailure(error)
                return
            }
            let respse = response as? HTTPURLResponse
            let errrCode = respse?.statusCode
            
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    
                    let errorTemp = NSError(domain:"", code:errrCode!, userInfo:["NSLocalizedDescriptionKey":"Server Error"])
                    onFailure(errorTemp)
                    return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let _ = String(data: data, encoding: .utf8) {
                //print ("got data: \(dataString)")
            }
            
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(CurrentWeather.self, from: data!)
                    onSuccess(jsonData)
                }catch{
                    onFailure(NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                }
            }
        }
        task.resume()
    }
    
    static func checkErrorCode(_ errorCode: Int) -> SiddError {
        switch errorCode {
        case 400:
            return .invalidRequest
        case 401:
            return .invalidCredentials
        case 404:
            return .notFound
        case 405:
            return .invalidRequest
        case 500:
            return .serverError
        case -1009:
            return .connectionError
        case -1001:
            return .timeOut
        default:
            return .unknownError
            
        }
    }
}
