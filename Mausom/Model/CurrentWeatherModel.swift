//
//  CurrentWeather.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let request: Request
    let location: Location
    let current: Current
}

// MARK: CurrentWeather convenience initializers and mutators

extension CurrentWeather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CurrentWeather.self, from: data)
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
        request: Request? = nil,
        location: Location? = nil,
        current: Current? = nil
    ) -> CurrentWeather {
        return CurrentWeather(
            request: request ?? self.request,
            location: location ?? self.location,
            current: current ?? self.current
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
