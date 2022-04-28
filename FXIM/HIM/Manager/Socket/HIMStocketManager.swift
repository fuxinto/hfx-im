//
//  HIMStocketManager.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/25.
//

import Foundation

fileprivate struct HIMGateModel:Codable{
    let host:String
    let port:UInt16
}
fileprivate struct HIMDNSModel:Codable{
    let dns:[HIMGateModel]
}

class HIMStocketManager: NSObject{
    //心疼定时器
    fileprivate var heartTimer : DispatchSourceTimer!
    /// 是否连接
   fileprivate var isConnected = false
    //是否重连
    fileprivate var isReConnect = false
    //重连时间间隔
   fileprivate  var timeInterval : Double = 3
    
   fileprivate var clientSocket:HIMSocketDelegate!
    
  fileprivate let messageListener = HIMMessageListener()

    let loginManager = HIMLoginManager()
    //断开重连
   fileprivate  func startReConnect() {
       if(!isConnected && self.timeInterval<65 && loginManager.isLogin){
            //启动一个定时器执行
            // 4.GCD 主线程/子线程
            DispatchQueue.global().asyncAfter(deadline: .now() + timeInterval) {
                //每次从连接时间隔时间*2,步长越来越长
                self.timeInterval = self.timeInterval*2
                self.startConnect()
            }
        }
    }
    
    var host:String!
    var port:UInt16!
    
    override init() {
        super.init()
        loginManager.loginDelegate = self
        messageListener.loginManager = loginManager
        messageListener.initMesListener()
        clientSocket = HIMClientSocket.init(stateListener: self, messageListener: messageListener)
        //启动一个定时器执行心跳
        heartTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        heartTimer.schedule(wallDeadline: .now(), repeating: .seconds(10))
        // 设定时间源的触发事件
        heartTimer.setEventHandler(handler: {
            messageListener.messagePushHandler.pullMsg()
        })
    }
    
    func push(body:Data) {
        guard self.isConnected else {
            self.startReConnect()
            return
        }
        FXLog("本次发送包体大小为：\(body.count)")
        var a:Int32 = Int32(body.count)
        let lenth = Data(bytes: &a, count: 4)
        let msg = lenth+body
        FXLog("封包后大小：\(msg.count)")
        clientSocket.write(data: msg)
    }
    // MARK: - Private Selector
    fileprivate func sendLoginMessage(){
        loginManager.sendLoginMessage()
    }
    fileprivate var dns:HIMDNSModel!{
        didSet{
            guard let gate = dns.dns.first else {
                FXLog("未找到可用gate地址")
                return
            }
            host = gate.host
            port = gate.port
            
            startConnect()
        }
    }
    
    func getDns() {
        FXNetworkTools.request(.getDns, HIMDNSModel.self, completion: {result in
            switch result{
            case .success(let resultModel):
                self.dns = resultModel.data
            default:
                break
            }})
    }
    
    func stopConnect() {
        isReConnect = false
        clientSocket.stopConnect()
    }
    fileprivate func startConnect(){
        self.clientSocket.startConnect(host: host, port: port)
    }

    
    fileprivate func startHeartBeat() {
        heartTimer.resume()
    }
    fileprivate func stopHeartBeat() {
        heartTimer.suspend()
    }
}


extension HIMStocketManager:HIMStateListenerDelegate{
    /// 连接成功回调
    func connectSuccess() {
        isConnected = true
        //发送登录消息
        sendLoginMessage()
      
        FXLog("连接成功")
    }
    
    func disconnected() {
        isConnected = false
        stopHeartBeat()
        FXLog("连接断开")
        startReConnect()
    }
}
extension HIMStocketManager:HIMLoginDelegate{
    func loginSucc() {
        FXLog("登录成功")
        timeInterval = 3
        isReConnect = true
        startHeartBeat()
    }
    func loginFail() {
//        timeInterval = 3
//        isReConnect = true
//        startHeartBeat()
        isReConnect = false
    }
}
