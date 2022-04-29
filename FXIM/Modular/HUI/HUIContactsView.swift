//
//  HUIChatView.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/3.
//

import SwiftUI

struct HUIContactsView: View {
    var body: some View {
        NavigationView {
            Button {
//                var msg = Pb_Message.init()
//                msg.type = .text
//                msg.content = "测试数据"
//                do{
//                    let data = try HIMMessageGen.createPack(body: msg, type: .msgReq)
//                    HIMSDK.shared.socketManager.push(body: data)
//                }catch{
//
//                }
                
              
               
            } label: {
                Text("发送消息")
            }
        }
    }
}

struct HUIContactsView_Previews: PreviewProvider {
    static var previews: some View {
        HUIContactsView()
    }
}
