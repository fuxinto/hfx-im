//
//  FXAPI.swift
//  FXRecipes
//
//  Created by 湘 zhou on 2021/3/19.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation
import Moya

enum FXAPI {
    case passwordLogin(account:String,password:String)
    case getDns
}

extension FXAPI:TargetType{
    var baseURL: URL {
        return URL.init(string:Moya_baseURL)!
    }
    
    var path: String {
        switch self {
        case .passwordLogin:
            return "user/login"
        case .getDns:
            return "user/dns"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDns:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var parameters = [String:Any]()
        switch self {
        case .passwordLogin(let account,let password):
            parameters["username"] = account
            parameters["password"] = password
        default:
            return .requestPlain
        }
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
    }
    
    var headers: [String : String]?{
        var headers = [String:String]()
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = FXIMAppManager.share.token
//        switch self {
        //添加浏览
//        case .recipeDeatil,.login:
//            headers["uuid"] = FXApp.shared.uuid
//        default:
//            break
//        }
        return headers
    }
}
