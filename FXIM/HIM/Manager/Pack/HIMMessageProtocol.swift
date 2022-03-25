//
//  FXConnectProtocol.swift
//  FXIMDemo
//
//  Created by hfx on 2021/8/27.
//

import Foundation
import SwiftProtobuf

protocol HIMMessageProtocol{
    //消息处理
    func handler(pack: Pb_Pack);
    
}

//拓展这个protocol，使方法变为可选实现
extension HIMMessageProtocol {
    func handler(pack: Pb_Pack) {
    }
}

