//
//  AccessTokenEntity.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import Foundation

public struct AccessTokenEntity: Decodable {
    public let clientId: String
    public let scopes: [String]
    public let token: String
}
