//
//  FXLoginManager.swift
//  FXIMDemo
//
//  Created by hfx on 2021/8/27.
//

import Foundation

class HIMLoginManager: HIMBaseHandler<Pb_LoginAck> {
    var token:String!
    var userId:String!
  
     var succ:HIMSucc?
     var fail:HIMFail?
    //是否登录状态
    var isLogin = false{
        didSet{
            if isLogin {
                FXMain {
                    self.succ?()
                }
            }
        }
    }
    
    func sendLoginMessage() {
        if let data = HIMMessageGen.createLoginMsg(token: token) {
            HIMSDK.shared.socketManager.push(body: data)
        }
    }

    func login(userId:String,token:String,succ:@escaping HIMSucc,fail:@escaping HIMFail) {
        self.token = token
        self.userId = userId
        self.succ = succ
        self.fail = fail
        HIMSDK.shared.socketManager.getDns()
    }
    
    func logout(succ:@escaping HIMSucc,fail:@escaping HIMFail) {
        self.succ = succ
        self.fail = fail
    }


}


