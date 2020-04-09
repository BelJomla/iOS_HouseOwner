//
//  ErrorLogger.swift
//  BJ_HouseOwner
//
//  Created by Project X on 4/9/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation

enum LogType: String{
    case error
    case warning
    case success
    case action
    case canceled
}

class Logger{
    static var logCount = 0
    
    static func log(_ logType:LogType,_ message:String){
        Logger.logCount += 1
        
        switch logType {
        case LogType.error:
            print("\n📕 Error: LogCat(\(Logger.logCount)) \(message)\n")
        case LogType.warning:
            print("\n📙 Warning: LogCat(\(Logger.logCount)) \(message)\n")
        case LogType.success:
            print("\n📗 Success: LogCat(\(Logger.logCount)) \(message)\n")
        case LogType.action:
            print("\n📘 Action: LogCat(\(Logger.logCount)) \(message)\n")
        case LogType.canceled:
            print("\n📓 Cancelled: LogCat(\(Logger.logCount)) \(message)\n")
        }
    }
    
}
