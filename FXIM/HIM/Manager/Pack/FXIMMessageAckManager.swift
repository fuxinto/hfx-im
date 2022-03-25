//
//  FXMessageACKManager.swift
//  FXRecipes
//
//  Created by hfx on 2021/8/31.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation

class FXIMMessageAckManager: FXIMBaseManager<Pb_MessageAck> {
 
    override func bodyClass() -> Pb_MessageAck.Type {
        return Pb_MessageAck.self
    }
    
    override func receive(body:Pb_MessageAck) {
        FXLog("收到消息Ack：\(body.messageID)")
    
    }
}
