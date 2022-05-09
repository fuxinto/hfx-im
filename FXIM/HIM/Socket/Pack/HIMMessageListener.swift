//
//  HIMMessageManager.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/21.
//

import Foundation
import SwiftProtobuf
enum HIMFrameType:UInt8{
    case binary  = 0
    case close   = 10
    case ping    = 11
    case pong    = 12
}

class HIMMessageListener:NSObject,HIMMessageListenerDelegate {
    fileprivate var receiveData = Data.init()
    let loginAckHandler = HIMLoginAckHandler()
    let messageManager = HIMMessageManager()
    let messageAckHandler = HIMMessageAckHandler()
    let messagePushHandler = HIMMessagePushHandler()
    let sessionHandler = HIMSessionPushHandler()
    var handlerDict = Dictionary<Pb_PackType,HIMMessageProtocol>()
//   var messageTypeDict = [Int16:FXIMPbSerializedProtocol.Type]()
    
    override init(){
        super.init()
        initMesListener()
    }
    
    func initMesListener() {
        setHandler(type: Pb_PackType.loginAck, handler: loginAckHandler)
        setHandler(type: Pb_PackType.msgAck, handler:messageAckHandler)
        setHandler(type: Pb_PackType.msgReq, handler: messageManager)
        setHandler(type: Pb_PackType.msgPush, handler: messagePushHandler)
        setHandler(type: Pb_PackType.sessionPull, handler: sessionHandler)
    }
    
    fileprivate func setHandler(type:Pb_PackType,handler:HIMMessageProtocol){
        handlerDict[type]=handler;
    }
    fileprivate func getHandler(type:Pb_PackType)->HIMMessageProtocol?{
        return handlerDict[type];
    }
    func receive(data: Data) {
        guard let pack = unpack(data: data) else { return  }
        //根据类型获取消息处理器
        if let absHandler = handlerDict[pack.type] {
            absHandler.handler(pack: pack)
        }else {
            FXLog("没有对应的消息处理器")
        }
    }
    //解包
    func unpack(data:Data) -> Pb_Pack? {
        //包头大小
        let headerSize = 4
        receiveData.append(data)
        var lenth :Int32 = 0
        guard receiveData.count > headerSize else {
            return nil
        }
        (receiveData[0..<headerSize] as NSData).getBytes(&lenth, length: 4)
//                if lenth > 10240 {
//                    FXLog("超长消息，丢弃")
//                    lenth = 0
//                    receiveData = Data()
//                }
        let bodySize = Int(lenth)

        guard lenth > 0,receiveData.count >= bodySize + headerSize else {
            return nil
        }
        var model:Pb_Pack?
        do {
             model = try Pb_Pack(serializedData: receiveData[headerSize...bodySize-1+headerSize])
        } catch  {
            FXLog("pbpack解析失败,消息丢失")
        }
        receiveData.removeSubrange(0...bodySize-1+headerSize)
        return model
    }
  
}
