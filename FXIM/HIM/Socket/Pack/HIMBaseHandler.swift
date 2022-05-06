//
//  FXBaseHandler.swift
//  FXIMDemo
//
//  Created by hfx on 2021/8/27.
//

import Foundation

import SwiftProtobuf


class HIMBaseHandler<T:SwiftProtobuf.Message>:NSObject,HIMMessageProtocol {
        //业务分发
    func handler(pack: Pb_Pack) {
        do {
            //转换成特定的消息类型
            let message = try bodyClass().init(serializedData:pack.body)
            receive(body: message)
        } catch  {
            FXLog(error)
        }
    }
    //--------------------下面是子类必须要实现的方法--------------------------------
    //返回子类需要的泛型类
    func bodyClass()->T.Type{
        return T.self;
    }
    func receive(body:T) {
        
    }
}
