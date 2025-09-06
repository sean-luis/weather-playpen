/*
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

public struct WPPCurrentDTO: Codable, Sendable {
    let coord: WPPCoordDTO?
    let weather: [WPPWeatherDTO]?
    let base: String?
    let main: WPPMainDTO?
    let visibility: Int?
    let wind: WPPWindDTO?
    let rain: WPPRainDTO?
    let clouds: WPPCloudsDTO?
    let dt: Int?
    let sys: WPPSysDTO?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
    
    public init(coord: WPPCoordDTO? = nil,
                weather: [WPPWeatherDTO]? = nil,
                base: String? = nil,
                main: WPPMainDTO? = nil,
                visibility: Int? = nil,
                wind: WPPWindDTO? = nil,
                rain: WPPRainDTO? = nil,
                clouds: WPPCloudsDTO? = nil,
                dt: Int? = nil,
                sys: WPPSysDTO? = nil,
                timezone: Int? = nil,
                id: Int? = nil,
                name: String? = nil,
                cod: Int? = nil) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.rain = rain
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }
}

public struct WPPCoordDTO: Codable, Sendable {
    let lon: Double?
    let lat: Double?
    
    public init(lon: Double? = nil,
                lat: Double? = nil) {
        self.lon = lon
        self.lat = lat
    }
}

public struct WPPSysDTO: Codable, Sendable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
    
    public init(type: Int? = nil,
                id: Int? = nil,
                country: String? = nil,
                sunrise: Int? = nil,
                sunset: Int? = nil) {
        self.type = type
        self.id = id
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

public struct WPPRainDTO: Codable, Sendable {
    let oneH: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
    
    public init(oneH: Double? = nil) {
        self.oneH = oneH
    }
}

public struct WPPWindDTO: Codable, Sendable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
    public init(speed: Double? = nil,
                deg: Int? = nil,
                gust: Double? = nil) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}

public struct WPPMainDTO: Codable, Sendable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let humidity: Int?
    let sea_level: Int?
    let grnd_level: Int?
    
    public init(temp: Double? = nil,
                feels_like: Double? = nil,
                temp_min: Double? = nil,
                temp_max: Double? = nil,
                pressure: Int? = nil,
                humidity: Int? = nil,
                sea_level: Int? = nil,
                grnd_level: Int? = nil) {
        self.temp = temp
        self.feels_like = feels_like
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.humidity = humidity
        self.sea_level = sea_level
        self.grnd_level = grnd_level
    }
}

public struct WPPWeatherDTO: Codable, Sendable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
    
    public init(id: Int? = nil,
                main: String? = nil,
                description: String? = nil,
                icon: String? = nil) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

public struct WPPCloudsDTO: Codable, Sendable {
    let all : Int?
    
    public init(all: Int? = nil) {
        self.all = all
    }
}
