//
//  FXLoginManager.swift
//  FXIMDemo
//
//  Created by hfx on 2021/8/27.
//

import Foundation

protocol HIMLoginDelegate:NSObjectProtocol {
    func loginSucc()
    
    func loginFail()
}
class HIMLoginManager: FXIMBaseManager<Pb_LoginAck> {
    var token:String!
    var userId:String!
    weak var loginDelegate:HIMLoginDelegate?
    fileprivate var succ:HIMSucc?
    fileprivate var fail:HIMFail?
    //是否登录状态
   fileprivate var isLogin = false
    
    func sendLoginMessage() {
        if let data = try? FXIMMessageGen.createLoginMsg(token: token) {
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

    override func bodyClass() -> Pb_LoginAck.Type {
        return Pb_LoginAck.self
    }
    
    override func receive(body:Pb_LoginAck) {
        if isLogin {
            return
        }
//        , body.userID == self.userId/
        guard body.code == 200 else {
            if !isLogin {
                FXMain {
                    self.fail?(Int(body.code),body.msg)
                }
            }
            return
        }
        //这三行代码注意执行顺序
        isLogin = true
        loginDelegate?.loginSucc()
        FXMain {
            self.succ?()
        }

    }

}


