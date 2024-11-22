
import Foundation

struct WeatherData {
    let cityName: String
    let temperature: Int
    let date: String
    let weatherIcon: String

    init(from response: OpenWeatherResponse) {
        self.cityName = response.city?.name ?? "Unknown City"
        self.temperature = Int(response.list.first?.main.temp ?? 0.0)
        self.date = response.list.first?.dtTxt ?? "Unknown Date"

        let condition = response.list.first?.weather.first?.main.lowercased() ?? "default"
        switch condition {
        case "rain": self.weatherIcon = "cloud.rain.fill"
        case "clear": self.weatherIcon = "sun.max.fill"
        case "clouds": self.weatherIcon = "cloud.fill"
        case "snow": self.weatherIcon = "cloud.snow.fill"
        default: self.weatherIcon = "questionmark"
        }
    }

}

struct OpenWeatherResponse: Codable {
    let city: City?
    let list: [WeatherEntry]

    struct City: Codable {
        let name: String?
    }

    struct WeatherEntry: Codable {
        let main: Main
        let weather: [Weather]
        let dtTxt: String

        enum CodingKeys: String, CodingKey {
            case main, weather
            case dtTxt = "dt_txt"
        }

        struct Main: Codable {
            let temp: Double
        }

        struct Weather: Codable {
            let main: String
        }
    }
}

