//
//  RequestModel.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import Foundation
// MARK: - Request
struct Request: Codable {
    let type, query, language, unit: String
}

// MARK: Request convenience initializers and mutators

extension Request {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Request.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: String? = nil,
        query: String? = nil,
        language: String? = nil,
        unit: String? = nil
    ) -> Request {
        return Request(
            type: type ?? self.type,
            query: query ?? self.query,
            language: language ?? self.language,
            unit: unit ?? self.unit
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
