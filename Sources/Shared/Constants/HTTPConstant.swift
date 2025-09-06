enum HTTPConstant {
    enum QueryParameter: String {
        case latitude = "lat"
        case longitude = "lon"
        case apiKey = "appid"
        case units = "units"
    }
    
    enum DictionaryValue: String {
        case metric = "metric"
        case middayTimeStamp = "12:00:00"
        case rain = "rain"
        case clear = "clear"
        case clouds = "clouds"
    }
}
