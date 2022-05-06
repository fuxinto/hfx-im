//
//  LoginView.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/21.
//

import SwiftUI

struct FXLoginView: View {
    @State var account = ""
    @State var isPush = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Spacer()
            Text("账号")
                
            TextField("请输入账号",text: $account)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
//            NavigationLink(destination: HUIChatListView(), isActive: $isPush) {
//
//                Button("登录") {
//                    FXIMAppManager.share.userManager.passwordLogin(account: "fuxinto", password: "fuxintojack135941") { isLogin in
//                        self.isPush = isLogin
//                    }
//                }
//                .foregroundColor(.white)
//                .frame(width: SCREEN_WIDTH-40, height: 50, alignment: .center)
//                .background(Color.blue)
//                .cornerRadius(22)
//
//            }
            
            Button("登录") {
                FXIMAppManager.share.passwordLogin(account: account, password: "fuxintojack135941")
            }
            .foregroundColor(.white)
            .frame(width: SCREEN_WIDTH-40, height: 50, alignment: .center)
            .background(Color.blue)
            .cornerRadius(22)
            Spacer()
        }).padding()
    }
}
private extension FXLoginView {
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        FXLoginView()
    }
}
