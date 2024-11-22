import SwiftUI

struct LandingPageView: View {
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToResult = false

    var body: some View {
        ZStack {
            NavigationView {
                VStack(spacing: 20) {
                    TextField("Enter Latitude", text: $latitude)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    TextField("Enter Longitude", text: $longitude)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    Button("Fetch Weather") {
                        if latitude.isEmpty || longitude.isEmpty {
                            alertMessage = "Both latitude and longitude are required."
                            showAlert = true
                        } else {
                            viewModel.fetchWeatherData(latitude: latitude, longitude: longitude)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if viewModel.weatherData != nil {
                                    navigateToResult = true // Trigger navigation
                                } else if !viewModel.errorMessage.isEmpty {
                                    alertMessage = viewModel.errorMessage
                                    showAlert = true
                                }
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    
                    NavigationLink(destination: ResultPageView(viewModel: viewModel, latitude: latitude, longitude: longitude),
                                   isActive: $navigateToResult) {
                        EmptyView()
                    }
                }
                .padding()
                .navigationTitle("Weather App")
            }
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .scaleEffect(1.5)
            }
        }
    }
}

#Preview {
    LandingPageView()
}
