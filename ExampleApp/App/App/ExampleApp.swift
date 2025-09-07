import SwiftUI
import FactoryKit
import WeatherPlaypen

@main
struct ExampleApp {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
}

extension ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

#Preview {
    let _ = Container.shared.interactor.register { PreviewInteractor() }
    let _ = Container.shared.locationInteractor.register { PreviewLocationInteractor() }
    MainView()
}
