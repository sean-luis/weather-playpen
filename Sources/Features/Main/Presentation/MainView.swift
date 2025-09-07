import SwiftUI
import FactoryKit

public struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            todaysWeatherView
            forecastWeatherView
        }
        .onAppear {
            Task { await viewModel.fetchWeatherToday() }
            Task { await viewModel.fetchWeatherForecast() }
        }
    }
}

// MARK: Todays weather view
extension MainView {
    private var todaysWeatherView: some View {
        ZStack(alignment: .top) {
            backgroundColorView
            backgroundImageView
            VStack(alignment: .center) {
                Spacer()
                minCurrentMaxView
                HorizontalDivider()
            }
        }
    }
    
    private var minCurrentMaxView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(viewModel.weatherTodayResponse.minimumTemp)
                Text("min")
            }
            Spacer()
            VStack {
                Text(viewModel.weatherTodayResponse.currentTemp)
                Text("Current")
            }
            Spacer()
            VStack(alignment: .leading) {
                Text(viewModel.weatherTodayResponse.maximumTemp)
                Text("max")
            }
        }
        .shimmer(viewModel.weatherTodayResponse == WeatherToday.emptyState ? .constant(.loading) : .constant(.ready))
        .animation(.easeInOut, value: viewModel.weatherTodayResponse)
        .font(.title2)
        .foregroundStyle(.white)
        .padding([.leading, .trailing], 16)
    }
}

// MARK: Forecast weather view
extension MainView {
    private var forecastWeatherView: some View {
        ZStack(alignment: .top) {
            backgroundColorView
            dayOfWeekView
                .padding(.top)
        }
    }
    
    private var dayOfWeekView: some View {
        VStack {
            ForEach(viewModel.weatherForecastResponse.forecast, id: \.self) { day in
                ZStack {
                    HStack(alignment: .center) {
                        Text(day.dayOfWeek)
                        Spacer()
                        Text(day.temperature)
                    }
                    
                    if let icon = day.weatherType.icon {
                        icon
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
            }
            .shimmer(viewModel.weatherForecastResponse == WeatherForecast.emptyState ? .constant(.loading) : .constant(.ready))
        }
        .font(.title)
        .foregroundStyle(.white)
        .padding([.leading, .trailing], 16)
    }
}

// MARK: Shared
extension MainView {
    private var backgroundImageView: some View {
        viewModel.weatherTodayResponse.weatherType.backgroundImage
            .resizable()
            .scaledToFit()
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                VStack {
                    Group {
                        Text(viewModel.weatherTodayResponse.currentTemp)
                        Text(viewModel.weatherTodayResponse.weatherType.description)
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                }
                .padding(.top, 50)
            }
    }
    
    private var backgroundColorView: some View {
        Rectangle()
            .fill(
                viewModel.weatherTodayResponse.weatherType.color
            )
            .ignoresSafeArea()
    }
}
