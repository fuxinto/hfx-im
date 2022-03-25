//
//  FXLagMonitor.swift
//  FXRecipes
//
//  Created by 黄福鑫 on 2022/2/8.
//  Copyright © 2022 黄福鑫. All rights reserved.
//

import Foundation

class FXLagMonitor {
    static let shared = FXLagMonitor()
    var isMoniting = false
    var runLoopActivity: CFRunLoopActivity = .entry
    var dispatchSemaphore: DispatchSemaphore? = DispatchSemaphore(value: 0)
    var timeoutCount = 0
    var runloopObserver: CFRunLoopObserver?
    private init(){
        
    }
    func starMonitor() {
        //正在while循环监控中，return
        if isMoniting {
            return
        }
        self.runloopObserver = buildRunLoopObserver()
        if self.runloopObserver == nil {
            FXLog("创建监听失败...")
            return
        }
        isMoniting = true
        CFRunLoopAddObserver(CFRunLoopGetMain(), runloopObserver, .commonModes)
        
        DispatchQueue.global().async {
            while true {
                //如果每秒少于50帧
                let wait = self.dispatchSemaphore?.wait(timeout: DispatchTime.now() + 1/50)
                if DispatchTimeoutResult.timedOut == wait {
                    guard let _ = self.runloopObserver else {
                        self.dispatchSemaphore = nil
                        self.runLoopActivity = .entry
                        self.timeoutCount = 0
                        return
                    }
                    if self.runLoopActivity == .beforeSources || self.runLoopActivity == .afterWaiting {
                        self.timeoutCount += 1
                        if self.timeoutCount < 5 {
                            continue
                        }
                        //最高优先级
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                            FXLog("卡顿了")
                        }
                    }
                }
                self.timeoutCount = 0
               
            }
        }
    }
    
    func endMonitor() {
        if self.runloopObserver == nil {
            return
        }
        self.isMoniting = false
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), self.runloopObserver, CFRunLoopMode.commonModes)
        self.runloopObserver = nil
    }
    
    private func buildRunLoopObserver() -> CFRunLoopObserver? {
        let info = Unmanaged<FXLagMonitor>.passUnretained(self).toOpaque()
        var context = CFRunLoopObserverContext(version: 0, info: info, retain: nil, release: nil, copyDescription: nil)
        let observer = CFRunLoopObserverCreate(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, runLoopObserverCallback(), &context)
        return observer
    }
    
    func runLoopObserverCallback() -> CFRunLoopObserverCallBack {
        return { observer, activity, info in
    
            guard let info = info else {
                return
            }
            let weakSelf = Unmanaged<FXLagMonitor>.fromOpaque(info).takeUnretainedValue()
            weakSelf.runLoopActivity = activity
            weakSelf.dispatchSemaphore?.signal()
        }
    }
}
