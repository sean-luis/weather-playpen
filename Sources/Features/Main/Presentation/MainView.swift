import SwiftUI
import FactoryKit

public struct MainView: View {
    @StateObject var viewModel = MainViewModel()

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
    MainView()
}
