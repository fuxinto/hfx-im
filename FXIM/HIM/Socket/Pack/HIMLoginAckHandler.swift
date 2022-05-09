//
//  HIMLoginAckHandler.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/5/7.
//

import Foundation

protocol HIMLoginDelegate:NSObjectProtocol {
    func loginSucc()
    
    func loginFail()
}
class HIMLoginAckHandler : HIMBaseHandler<Pb_LoginAck>{
    weak var loginDelegate:HIMLoginDelegate?
    
    override func bodyClass() -> Pb_LoginAck.Type {
        return Pb_LoginAck.self
    }
    
    override func receive(body:Pb_LoginAck) {
        if HIMSDK.shared.loginManager.isLogin,body.code == 200 {
            loginDelegate?.loginSucc()
            return
        }
        
        switch body.code{
        case 200:
            HIMSDK.shared.loginManager.isLogin = true
            loginDelegate?.loginSucc()
            FXMain {
                HIMSDK.shared.loginManager.succ?()
            }
        case 401:
            //踢出登录
            HIMSDK.shared.loginManager.isLogin = false
            HIMSDK.shared.listener?.onUserSigExpired()
            
        default:
            //登录失败
            FXMain {
                HIMSDK.shared.loginManager.fail?(Int(body.code),body.msg)
            }
        }
        
    }}
