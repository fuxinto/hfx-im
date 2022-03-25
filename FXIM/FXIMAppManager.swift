//
//  FXIMAppManager.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/22.
//

import Foundation

class FXIMAppManager:ObservableObject{
    @Published
    var isLogin = false
    static let share = FXIMAppManager()
    var user : FXUser?
    fileprivate init() {
        
    }
    
    var account:String!
    @UserDefault("LSUserTokenKey", defaultValue: "")
    var token:String!
    func passwordLogin(account:String,password:String) {
    
        FXNetworkTools.request(.passwordLogin(account: account, password: password), FXUser.self, completion: {result in
            switch result{
            case .success(let resultModel):
                guard let model = resultModel.data else { return  }
                self.user = model
                self.token = model.userToken
                self.startHIM()
            default:
                break
            }})
    }
    func startHIM(){
        guard let model = user else {
            return
        }
        HIMSDK.shared.login(userId: model.uid, token: model.userToken) {
            self.isLogin = true
        } fail: { code, msg in
            FXHud.showText(msg)
        }
    }
}
