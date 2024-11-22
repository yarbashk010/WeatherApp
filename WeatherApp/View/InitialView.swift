
import SwiftUI

struct InitialView: View {
    @AppStorage("isFreshUser") private var isFreshUser: Bool = true

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: "https://img.freepik.com/premium-vector/cute-smiling-sun-vector-icon_197792-591.jpg")) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 150, height: 150)
                } placeholder: {
                    ProgressView()
                }

                Text("Welcome to the Weather App! Here, you can check weather details for any location.")
                    .padding()
                    .multilineTextAlignment(.center)

                Button("Get Started") {
                    isFreshUser = false
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("About")
        }
    }
}


#Preview {
    InitialView()
}
