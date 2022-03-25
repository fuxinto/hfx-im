//
//  HIMSDK.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/21.
//

import Foundation
import UIKit


protocol HIMStateListenerDelegate:NSObjectProtocol{
    func connectSuccess()
    func disconnected()
}
protocol HIMMessageListenerDelegate:NSObjectProtocol {
    func receive(data:Data)
}
protocol HIMSocketDelegate {

    
    func write(data:Data)
    /// 开始连接
    /// - Parameter addr: socket host:port
    func startConnect(host:String,port:UInt16)
    func stopConnect()
}


class HIMSDK{
    static let shared = HIMSDK()
    // MARK: - Private Properties
    
    let socketManager = HIMStocketManager()
    
    fileprivate init (){
        
    }

    func login(userId:String,token:String,succ:@escaping HIMSucc,fail:@escaping HIMFail) {
        socketManager.loginManager.login(userId: userId, token: token, succ: succ, fail: fail)
    }

 
}
