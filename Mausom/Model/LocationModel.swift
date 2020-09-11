//
//  LocationHelper.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import Foundation
// MARK: - Location
struct Location: Codable {
    let name, country, region, lat: String
    let lon, timezoneID, localtime: String
    let localtimeEpoch: Int
    let utcOffset: String

    enum CodingKeys: String, CodingKey {
        case name, country, region, lat, lon
        case timezoneID = "timezone_id"
        case localtime
        case localtimeEpoch = "localtime_epoch"
        case utcOffset = "utc_offset"
    }
}

// MARK: Location convenience initializers and mutators

extension Location {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Location.self, from: data)
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
        name: String? = nil,
        country: String? = nil,
        region: String? = nil,
        lat: String? = nil,
        lon: String? = nil,
        timezoneID: String? = nil,
        localtime: String? = nil,
        localtimeEpoch: Int? = nil,
        utcOffset: String? = nil
    ) -> Location {
        return Location(
            name: name ?? self.name,
            country: country ?? self.country,
            region: region ?? self.region,
            lat: lat ?? self.lat,
            lon: lon ?? self.lon,
            timezoneID: timezoneID ?? self.timezoneID,
            localtime: localtime ?? self.localtime,
            localtimeEpoch: localtimeEpoch ?? self.localtimeEpoch,
            utcOffset: utcOffset ?? self.utcOffset
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
