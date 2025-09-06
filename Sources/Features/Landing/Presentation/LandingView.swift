import SwiftUI
import FactoryKit

public struct LandingView: View {
    @StateObject var viewModel = LandingViewModel()

    public init() {}
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchWeatherToday()
                await viewModel.fetchWeatherForecast()
            }
        }
    }
}

#Preview {
    let _ = Container.shared.locationInteractor.register { PreviewLocationInteractor() }
    LandingView()
}
