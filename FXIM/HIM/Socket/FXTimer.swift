//
//  FXDispatchSourceTimer.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/5/5.
//

import Foundation

enum FXTimerState {
    case suspended
    case resumed
}

class FXTimer {
    typealias FXTimerStateHandler = (FXTimerState)-> Void
    var stateHandler:FXTimerStateHandler?
    // MARK: - 内部属性
    
    private let timeInterval: DispatchTimeInterval
    
    private var state: FXTimerState = .suspended {
        didSet {
            stateHandler?(state)
        }
    }
    
    private var handler:FXVoidHandler
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        t.schedule(deadline: .now() + self.timeInterval, repeating: self.timeInterval)
        t.setEventHandler(handler: { [weak self] in
            guard let self = self else { return }
            self.handler()
        })
        return t
    }()
    
    init(timeInterval: DispatchTimeInterval,handler:@escaping FXVoidHandler) {
        self.handler = handler
        self.timeInterval = timeInterval
    }
    
    deinit {
        cancel()
    }
}

// MARK: - About Public Custom Action
extension FXTimer {
    
    func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }

    func suspend() {
        if state == .suspended {
            return
        }
        state = .suspended
        timer.suspend()
    }
    
    func cancel() {
        timer.setEventHandler {}
        timer.cancel()
        /*
         If the timer is suspended, calling cancel without resuming
         triggers a crash. This is documented here https://forums.developer.apple.com/thread/15902
         */
        resume()
    }
    
}
