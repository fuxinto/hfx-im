//
//  MessageGen.swift
//  FXIMDemo
//
//  Created by hfx on 2021/8/27.
//

import Foundation
import SwiftProtobuf
class HIMMessageGen {
  
    /*创建ack*/
    class func createAck(msgId:String) throws -> Data?{
        var chatMsgResp = Pb_MessageAck.init()
        chatMsgResp.messagedUid = msgId
       return  createPack(body:chatMsgResp , type: Pb_PackType.msgAck)
    }
    //创建登录消息
    class func createLoginMsg(token:String) -> Data? {
        var signin = Pb_LoginReq.init()
        signin.token = token
        return  createPack(body:signin , type: Pb_PackType.loginReq)
    }
    
    class func createPack(body:SwiftProtobuf.Message?,type:Pb_PackType) -> Data? {
        var messageBuilder = Pb_Pack.init()
        messageBuilder.type = type
        do {
            if let msg = body {
                messageBuilder.body = try msg.serializedData()
            }
            return try messageBuilder.serializedData()
        } catch {
            FXLog(error.localizedDescription)
            return nil
        }
    }
}
