import SwiftUI

struct ResultPageView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let latitude: String
    let longitude: String

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching Weather Data...")
            } else if let data = viewModel.weatherData {
                VStack(spacing: 20) {
                    Text("City: \(data.cityName)")
                        .font(.title2)

                    Text("Temperature: \(data.temperature) °C")

                    Text("Date: \(formattedDate(from: data.date))")

                    Image(systemName: data.weatherIcon)
                        .font(.largeTitle)
                }
            } else {
                Text("Unable to fetch weather data.")
            }
        }
        .onAppear {
            viewModel.fetchWeatherData(latitude: latitude, longitude: longitude)
        }
    }

    func formattedDate(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return dateString
    }
}

struct ResultPageView_Previews: PreviewProvider {
    static var previews: some View {
        ResultPageView(
            viewModel: WeatherViewModel(),
            latitude: "9.9312",
            longitude: "76.2673"
        )
    }
}
