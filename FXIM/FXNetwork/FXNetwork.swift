//
//  FXNetwork.swift
//  FXRecipes
//
//  Created by 黄福鑫 zhou on 2021/3/19.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import Combine
// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
///但这里我没怎么用这个。。。 loading的逻辑直接放在网络处理里面了
private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    
    FXLog("networkPlugin \(changeType)")
    //targetType 是当前请求的基本信息
    switch(changeType){
    case .began:
        FXLog("开始请求网络")
    case .ended:
        FXLog("结束")
    }
}
/// 超时时长
private var requestTimeOut:Double = 30


//func signature(target:FXAPI) -> Endpoint{
//    var headers = target.headers ?? [String:String]()
//    
//   
//   
//    FXLog(headers)
//    
//    let endpoint = Endpoint(
//        url: target.baseURL.absoluteString + target.path,
//        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
//        method: target.method,
//        task: target.task,
//        httpHeaderFields: headers
//    )
//    return endpoint
//}

///网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
private let myEndpointClosure = { (target: FXAPI) -> Endpoint in
    ///这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
    

    let endpoint = Endpoint(
        url: target.baseURL.absoluteString + target.path,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    return endpoint
}

//网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        //        FXLog(request.httpBody?.fx.mapDictionary())
//        if let requestData = request.httpBody {
//            FXLog("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
//        }else{
//            FXLog("\(request.url!)"+"\(String(describing: request.httpMethod))")
//        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

// 插件写法
class FXRequestAlertPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        
        FXHud.showActivity()
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        FXHud.dismiss()
    }
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        
//        switch result {
//        case let .success(moyaResponse):
////            var key :String
////            if let userkey = FXApp.shared.userManager.userAesKey {
////                key = userkey
////            }else{
////                key = FXAES_Key
////            }
//            //aes解密
////            if let data = moyaResponse.data.fx.aesDecrypt(key:FXAES_Key, iv: FXAES_Iv) {
////
////                FXLog(String(data: data, encoding: .utf8))
////
////                let response = Response(statusCode: moyaResponse.statusCode, data: data, request: moyaResponse.request, response: moyaResponse.response)
////
////                let res = Result<Response, MoyaError>.success(response)
////                return res
////            }
//
////            let res = Result<Response, MoyaError>.failure(.encodableMapping(FXNetworkError.decryption))
//            return result
//
//        //                NotificationCenter.default.post(name: FXHiedNoNetworkNoNetworkNotification, object: nil)
//        case .failure(_):
//            if !isNetworkConnect{
//                //                FXLog("提示用户网络似乎出现了问题")
//                //                FXNoNetworkView.fx.loadFromNib().show()
//                FXHud.showText("网络中断，请检查网络后继续")
//                //                return
//            }
//        //            FXHud.showMessage(message: NetworkErrorDefaultMsg)
//        //            FXLog(NetworkErrorDefaultMsg)
//        }
        return result
    }

}

////网络请求发送的核心初始化方法，创建网络请求对象
let FXProvider = MoyaProvider<FXAPI>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [FXRequestAlertPlugin(),networkPlugin], trackInflights: false)


/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用get方法是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
var isNetworkConnect: Bool {
    get{
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true //无返回就默认网络已连接
    }
}


class FXDataModel<T:Codable>:Codable {
    var data :T?
    var msg : String?
    var code:Int?
}



class FXNetworkTools {
    
    
    public enum FXResponseResult<Success, Failure> where Failure: Error {
        
        /// A success, storing a `Success` value.
        case success(Success)
        
        /// A failure, storing a `Failure` value.
        case failure(Failure)
    }
    
    
//    static func request<T: Codable>(_ target: FXAPI, _ type: T.Type) -> Future<T?,FXNetworkError>{
//
//        let x = Future<T?,FXNetworkError>() { promise in
//            FXProvider.request(target) { (result) in
//                //隐藏hud
//                switch result {
//                case let .success(moyaResponse):
//                    FXLog(String(data: moyaResponse.data, encoding: .utf8))
//
//
//                    guard let reulstModel =  try? JSONDecoder.fx.decode(FXDataModel<T>.self, from: moyaResponse.data) else {
////                        FXLog(err.localizedDescription)
//                        promise(.failure(FXNetworkError.jsonParse))
//                        return
//                    }
//
//                    guard reulstModel.code == 200 else {
//                        promise(.failure(FXNetworkError.responseError))
//                        return
//                    }
//                    promise(.success(reulstModel.data))
//
//                case .failure(let moyaErr):
//                    FXLog(moyaErr)
//                    promise(.failure(FXNetworkError.responseError))
//                }
//            }
//
//        }
//
//        return x
//
//    }
    
    static func request<T: Codable>(_ target: FXAPI, _ type: T.Type,completion: @escaping (FXResponseResult<FXDataModel<T>, Error>)->Void){

        FXProvider.request(target) { (result) in
            //隐藏hud
            switch result {
            case let .success(moyaResponse):
                FXLog("请求接口："+target.path)
                FXLog(String(data: moyaResponse.data, encoding: .utf8))
                do {
                    let resultModel = try JSONDecoder().decode(FXDataModel<T>.self, from: moyaResponse.data)
                    guard resultModel.code == 200 else {
                        completion(.failure(FXNetworkError.responseError))
                        FXHud.showText(resultModel.msg ?? "没有返回错误msg")
                        return
                    }
                    completion(.success(resultModel))

                } catch (let err) {
                    FXLog(err.localizedDescription)
                    completion(.failure(FXNetworkError.jsonParse))
                    FXHud.showText(err.localizedDescription)
                }
                
            case .failure(let err):
                switch err {
                case .encodableMapping(let fxerr):
                    let text = fxerr.localizedDescription
                    FXLog(text)
                    FXHud.showText(text)
                    completion(.failure(fxerr))
                default:
                    FXHud.showText(NetworkErrorDefaultMsg)
                    FXLog(NetworkErrorDefaultMsg)
                    completion(.failure(err))
                }

            }
        }
    }
    func vaisCode() {
        
    }

}
