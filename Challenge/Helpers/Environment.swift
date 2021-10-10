//
//  Environment.swift
//  Challenge
//
//  Created by Serguei on 10/10/21.
//

import Foundation

enum Environment {
    static let baseURL: String = (NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Info", ofType: "plist") ?? "")?.object(forKey: "BASE_URL") ?? "") as! String
}
