//
//  HUISessionListViewModel.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/5/6.
//

import Foundation

class HUISessionListVM:NSObject,ObservableObject{
    @Published
    var sessions = [HUISessionCellData()]
    /**
     * 分页拉取的会话数量，默认是 100
     */
    var pagePullCount:Int = 100
    var nextSeq:Int = 0
    var isFinished = false
    var localSessionList = [HIMSession]()
    
    func loadSession() {
        if isFinished {
            return
        }
        HIMSDK.shared.sessionManager.getSessionList(offset: nextSeq, count: pagePullCount) { list, offet, isFinished in
            self.nextSeq = offet
            self.isFinished = isFinished
            
        } fail: { code, msg in
            
        }

    }
    
    func update(sessionList:[HIMSession]) {
        // 更新 UI 会话列表，如果 UI 会话列表有新增的会话，就替换，如果没有，就新增
        for session in sessionList {
            if let index = localSessionList.firstIndex(where: { localSession in
                return localSession.sessionId == session.sessionId
            }) {
                localSessionList.remove(at: index)
            }
            localSessionList.insert(session, at: 0)
        }
        // 更新 cell data
        var ary = [HUISessionCellData]()
        for session in localSessionList {
            var data = HUISessionCellData()
            data.sessionId = session.sessionId
            data.unreadCount = Int(session.unreadCount)
            if let msg = session.lastMessage {
                data.timestamp = msg.timestamp
            }
            data.title = session.showName
            ary.append(data)
        }
        sessions = sortDataList(dataList: ary)
        
    }
    override init() {
        super.init()
        HIMSDK.shared.sessionManager.listener = self
    }
    func sortDataList(dataList:[HUISessionCellData])-> [HUISessionCellData]{
       return dataList.sorted { data1, data2 in
            return data1.timestamp < data2.timestamp
        }
    }
    func getLastDisplayString(session:HIMSession) -> NSMutableAttributedString {
        return NSMutableAttributedString()
    }
}
extension HUISessionListVM: HIMSessionListener{
    
}
