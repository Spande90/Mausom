//
//  Current.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import Foundation

// MARK: - Current
struct Current: Codable {
    let observationTime: String
    let temperature, weatherCode: Int
    let weatherIcons: [String]
    let weatherDescriptions: [String]
    let windSpeed, windDegree: Int
    let windDir: String
    let pressure: Int
    let precip: Double
    let humidity, cloudcover, feelslike, uvIndex: Int
    let visibility: Int
    let isDay: String

    enum CodingKeys: String, CodingKey {
        case observationTime = "observation_time"
        case temperature
        case weatherCode = "weather_code"
        case weatherIcons = "weather_icons"
        case weatherDescriptions = "weather_descriptions"
        case windSpeed = "wind_speed"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressure, precip, humidity, cloudcover, feelslike
        case uvIndex = "uv_index"
        case visibility
        case isDay = "is_day"
    }
}

// MARK: Current convenience initializers and mutators

extension Current {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Current.self, from: data)
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
        observationTime: String? = nil,
        temperature: Int? = nil,
        weatherCode: Int? = nil,
        weatherIcons: [String]? = nil,
        weatherDescriptions: [String]? = nil,
        windSpeed: Int? = nil,
        windDegree: Int? = nil,
        windDir: String? = nil,
        pressure: Int? = nil,
        precip: Double? = nil,
        humidity: Int? = nil,
        cloudcover: Int? = nil,
        feelslike: Int? = nil,
        uvIndex: Int? = nil,
        visibility: Int? = nil,
        isDay: String? = nil
    ) -> Current {
        return Current(
            observationTime: observationTime ?? self.observationTime,
            temperature: temperature ?? self.temperature,
            weatherCode: weatherCode ?? self.weatherCode,
            weatherIcons: weatherIcons ?? self.weatherIcons,
            weatherDescriptions: weatherDescriptions ?? self.weatherDescriptions,
            windSpeed: windSpeed ?? self.windSpeed,
            windDegree: windDegree ?? self.windDegree,
            windDir: windDir ?? self.windDir,
            pressure: pressure ?? self.pressure,
            precip: precip ?? self.precip,
            humidity: humidity ?? self.humidity,
            cloudcover: cloudcover ?? self.cloudcover,
            feelslike: feelslike ?? self.feelslike,
            uvIndex: uvIndex ?? self.uvIndex,
            visibility: visibility ?? self.visibility,
            isDay: isDay ?? self.isDay
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
