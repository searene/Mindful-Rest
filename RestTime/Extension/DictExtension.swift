//
//  DictExtension.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/4.
//

import Foundation

extension Dictionary {
    
    func toJSONString() -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) as NSData
        return NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
    }
}
