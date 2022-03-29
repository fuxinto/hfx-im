//
//  HIMlientSocket.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/21.
//

import Foundation
import CocoaAsyncSocket
import SwiftProtobuf

class HIMClientSocket:NSObject,HIMSocketDelegate {
    weak var stateDelegate: HIMStateListenerDelegate?
    
    weak var messageDelegate: HIMMessageListenerDelegate?
    
    fileprivate var clientSocket : GCDAsyncSocket!
    
    init(stateListener:HIMStateListenerDelegate,messageListener:HIMMessageListenerDelegate) {

        self.stateDelegate = stateListener
        self.messageDelegate = messageListener
        super.init()
        clientSocket = GCDAsyncSocket.init(delegate: self, delegateQueue: .global())
        clientSocket.autoDisconnectOnClosedReadStream = false
    }
    
    //开始连接
    func startConnect(host:String,port:UInt16) {
        do {
            if clientSocket.isConnected {
                  clientSocket.disconnect()
              }
            try self.clientSocket.connect(toHost: host, onPort: port, withTimeout:30)
        } catch {
            FXLog("连接代码失败")
        }
    }
    //断开连接
    func stopConnect() {
      if clientSocket.isConnected {
            clientSocket.disconnect()
        }
    }
    
    func write(data: Data) {
        clientSocket.write(data, withTimeout: -1, tag: 1)
    
    }
}
//MARK:监听
extension HIMClientSocket:GCDAsyncSocketDelegate{
    //连接成功
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        self.clientSocket = sock
        stateDelegate?.connectSuccess()
        //每次读完数据后，都要调用一次监听数据的方法
         clientSocket.readData(withTimeout: -1, tag: 0)
    }
    //获取服务器消息
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        messageDelegate?.receive(data:data)
       //每次读完数据后，都要调用一次监听数据的方法
        clientSocket.readData(withTimeout: -1, tag: 0)
    }
    //断开连接
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        stateDelegate?.disconnected()
    }
    
}
