import SwiftUI
import FactoryKit
import WeatherPlaypen

struct LandingView: View {
    @StateObject var viewModel = LandingViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("Your current location is: \(String(describing: viewModel.$userLocation))")
        }
        .padding()
        .onAppear {
            viewModel.retrieveInitialLocationIfPossible()
            viewModel.setupLocationResponding()
        }
    }
}

#Preview {
    let _ = Container.shared.locationInteractor.register { PreviewLocationInteractor() }
    LandingView()
}
