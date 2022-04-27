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
class HIMLoginManager: HIMBaseManager<Pb_LoginAck> {
    var token:String!
    var userId:String!
    weak var loginDelegate:HIMLoginDelegate?
    fileprivate var succ:HIMSucc?
    fileprivate var fail:HIMFail?
    //是否登录状态
var isLogin = false
    
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
    
    override func bodyClass() -> Pb_LoginAck.Type {
        return Pb_LoginAck.self
    }
    
    override func receive(body:Pb_LoginAck) {
        if isLogin {
            return
        }
        
        switch body.code{
        case 200:
            isLogin = true
            loginDelegate?.loginSucc()
            FXMain {
                self.succ?()
            }

            
        case 401:
            isLogin = false
            //踢出登录
            FXMain {
                self.fail?(Int(body.code),body.msg)
            }
            break
        default:
            break
        }
        //这三行代码注意执行顺序
   
        
    }

}


