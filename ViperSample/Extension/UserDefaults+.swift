//
//  UserDefaults+.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/03.
//

import Foundation

extension UserDefaults {
    private var qiitaAccessTokenKey: String { "qiitaAccessTokenKey" }
    var qiitaAccessToken: String {
        get {
            self.string(forKey: qiitaAccessTokenKey) ?? ""
        }
        set {
            self.setValue(newValue, forKey: qiitaAccessTokenKey)
        }
    }
}
