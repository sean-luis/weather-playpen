/*
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

public struct WPPForecastDTO : Codable, Sendable {
    let cod: String?
    let message: Int?
    let cnt: Int?
    let list: [WWPListDTO]?
    let city: WPPCityDTO?
    
    public init(cod: String? = nil,
                message: Int? = nil,
                cnt: Int? = nil,
                list: [WWPListDTO]? = nil,
                city: WPPCityDTO? = nil) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

public struct WPPCityDTO: Codable, Sendable {
    let id: Int?
    let name: String?
    let coord: WPPCoordDTO?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
    
    public init(id: Int? = nil,
                name: String? = nil,
                coord: WPPCoordDTO? = nil,
                country: String? = nil,
                population: Int? = nil,
                timezone: Int? = nil,
                sunrise: Int? = nil,
                sunset: Int? = nil) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

public struct WWPListDTO: Codable, Sendable {
    let dt: Int?
    let main: WPPMainDTO?
    let weather: [WPPWeatherDTO]?
    let clouds: WPPCloudsDTO?
    let wind: WPPWindDTO?
    let visibility: Int?
    let pop: Double?
    let dt_txt: String?
    
    public init(dt: Int? = nil,
                main: WPPMainDTO? = nil,
                weather: [WPPWeatherDTO]? = nil,
                clouds: WPPCloudsDTO? = nil,
                wind: WPPWindDTO? = nil,
                visibility: Int? = nil,
                pop: Double? = nil,
                dt_txt: String? = nil) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.visibility = visibility
        self.pop = pop
        self.dt_txt = dt_txt
    }
}

public struct WWPSysDTO: Codable, Sendable {
    let pod : String?
    
    public init(pod: String? = nil) {
        self.pod = pod
    }
}
