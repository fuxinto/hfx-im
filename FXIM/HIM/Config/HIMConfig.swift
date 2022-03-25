//
//  HIMConfig.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/21.
//

import Foundation

// MARK: - socket
public let SocketServer_host      : String = "127.0.0.1"
public let SocketServer_port      : UInt16 = 8081


typealias HIMFail = (Int,String) -> Void
typealias HIMSucc = ()->Void
typealias HIMProgress = (UInt32)->Void
