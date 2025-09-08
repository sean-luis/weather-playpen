# Weather Playpen

An iOS application that integrates with [OpenWeather.org](https://openweathermap.org/)

## Table of Contents
* [Project tooling and architecture](#project-tooling-and-architecture)
* [Functionality](#functionality)
* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Screenshots](#screenshots)
* [Videos](#videos)

### Project tooling and architecture

* SwiftUI
* MVVM (Apple's [Combine](https://developer.apple.com/documentation/combine) for view model binding)
* Clean architecture (Presentation-Domain-Data)
* Test app + SPM package called WeatherPlaypen locally installed (essentially containing all source files created to accomplish the app)
* [Factory](https://github.com/hmlongco/Factory) for dependency injection
* [Cuckoo](https://github.com/Brightify/Cuckoo) for unit testing
* [Swiftlint](https://github.com/realm/SwiftLint) for code analysis and coding standards
* [Xcodegen](https://github.com/yonaskolb/XcodeGen) for project configuration and settings
* [Swiftgen](https://github.com/SwiftGen/SwiftGen) for asset handling (images, colors, strings)
* CI/CD build pipeline integration for [WeatherPlaypen](https://app.bitrise.io/app/c71cd178-58db-465f-a2cc-988e7ec4d36e)
* The Xcode project file + generated assets + generated mocks are added to gitignore and will only be found on the local installation (i.e. not in source control)

### Functionality

* Fetch and display [todays weather](https://openweathermap.org/current)
* Cache todays weather which allows offline usage (using UserDefaults - due to basic data structure, non-sensitive information, low read/write)
* Shimmer, fetch and display the [5 day forecast](https://openweathermap.org/forecast5#data)

### Prerequisites

* Xcode 16.2 and an API key (optional). To generate the API please visit [OpenWeather.org](https://openweathermap.org/)
* It takes only a minute to create your own API key but the project makes use of SwiftUI previews with mocked data injected for quick viewing
* Once you create your own key just replace DEMO_KEY inside the WeatherPlaypen package

### Installation

1. Clone the repo
```sh
git clone https://github.com/sean-luis/weather-playpen-ios.git
```
2. Use Fastlane to generate the assets and project:
```sh
bundle exec fastlane gen
```
This step, if successfuly, will open the project for you. You will need to install [xcodegen](https://github.com/yonaskolb/XcodeGen), [swiftlint](https://github.com/realm/SwiftLint) and [swiftgen](https://github.com/SwiftGen/SwiftGen) 
which is preferably done via [Homebrew](https://brew.sh/) for system wide installation. The project does not package the dependencies directly.

4. Search the project and replace DEMO_KEY with your generated API key (optional).

Otherwise, simply use SwiftUI preview to explore `MainView.swift` which uses dependency injection to inject mock weather reports for convenience and fast development.

### Screenshots

<img width="298" height="648" alt="LANDING" src="https://github.com/user-attachments/assets/914c3a49-e2c7-4982-a840-849c02ba941d" />

## Videos

First launch

https://github.com/user-attachments/assets/d5295c84-4f9f-4a00-be64-968a65eb307a

Subsequent launches (cross session/offline caching)

https://github.com/user-attachments/assets/fef48232-2a66-4aba-92f5-082fe576bf87






