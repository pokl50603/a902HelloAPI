//
//  APIModel.swift
//  a902HelloAPI
//
//  Created by shengyuan on 2022/10/22.
//
import Alamofire
import Foundation


class APIModel{
    static var share = APIModel()
    private init(){}
    
    private var server = "https://randomuser.me/"
    
    func queryRandomUser(completion: @escaping(_ Data:Any?,_ respError: Error?)->())->(){
        let apiUrlString = server + "api/"
        let parmeters:Parameters? = nil
        
        AF.request(apiUrlString,
                   method: .get,
                   parameters: parmeters,
                   encoding: URLEncoding.default,
                   headers: nil)
        .responseJSON{response in
            switch response.result{
            case .success(_):
                completion(response.data,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
}
