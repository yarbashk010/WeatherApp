


import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var isLoading: Bool = false
    @Published var errorMessage = String()
    @Published var myAPIKey = "faf8ecae10bd2ebb3fa7487bba18c4ac"



    func fetchWeatherData(latitude: String, longitude: String) {

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=faf8ecae10bd2ebb3fa7487bba18c4ac&units=metric&cnt=1") else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        errorMessage = ""

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
//                self?.isLoading = false
            }

            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to fetch data."
                }
                return
            }

            // Print the raw response data to check the structure
            if let jsonString = String(data: data, encoding: .utf8) {
                print("API Response: \(jsonString)")
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(OpenWeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.weatherData = WeatherData(from: result)
                    self?.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to decode weather data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

}
