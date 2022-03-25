//
//  MessageGen.swift
//  FXIMDemo
//
//  Created by hfx on 2021/8/27.
//

import Foundation
import SwiftProtobuf
class FXIMMessageGen {
  
    
    
    /*创建ack*/
    class func createAck(msgId:String) throws -> Data{
        var chatMsgResp = Pb_MessageAck.init()
        chatMsgResp.messagedUid = msgId
       return try createPack(body:chatMsgResp , type: Pb_PackType.msgAck)
    }
    //创建登录消息
    class func createLoginMsg(token:String)throws -> Data {
        var signin = Pb_LoginReq.init()
        signin.token = token
        return try createPack(body:signin , type: Pb_PackType.loginReq)
    }
    
    class func createPack(body:SwiftProtobuf.Message,type:Pb_PackType)throws -> Data {
        var messageBuilder = Pb_Pack.init()
        messageBuilder.type = type
        do {
            messageBuilder.body = try body.serializedData()
            return try messageBuilder.serializedData()
        } catch {
            FXLog(error)
            FXLog("protobuf序列化失败")
            throw HIMError.protobufSerializedFail
        }
    }
}
