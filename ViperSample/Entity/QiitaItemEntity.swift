//
//  QiitaItemEntity.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import Foundation

public struct QiitaItemEntity: Codable {
    public var urlStr: String
    public var title: String

    enum CodingKeys: String, CodingKey {
        case urlStr = "url"
        case title = "title"
    }
    public var url: URL? { URL.init(string: urlStr) }
}
