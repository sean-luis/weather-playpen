import SwiftUI
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
