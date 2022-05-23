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

protocol HIMSDKListener {
    func onConnecting()
    func onConnectSuccess()
    func onConnectFailed()
    func onKickedOffline()
    func onUserSigExpired()
    func onSelfInfoUpdated()
}

class HIMSDK{
    
    static let shared = HIMSDK()
    
    var listener:HIMSDKListener?
    // MARK: - Private Properties
    let loginManager = HIMLoginManager()
    let socketManager = HIMStocketManager()
    let messageManager = HIMMessageManager()
    let sessionManager = HIMSessionManager()
    fileprivate init (){
        
    }
    
}
