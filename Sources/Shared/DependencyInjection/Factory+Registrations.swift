import FactoryKit

extension Container {
    @MainActor
    public var interactor: Factory<WeatherInteractor> {
        self { @MainActor in WeatherInteractorImpl() as WeatherInteractor }
    }
    
    @MainActor
    public var repository: Factory<WeatherRepository> {
        self { @MainActor in WeatherRepositoryImpl() as WeatherRepository }
    }
    
    public var networkingProvider: Factory<NetworkingProvider> {
        self { NetworkingProviderImpl() as NetworkingProvider }
    }
    
    public var locationInteractor: Factory<LocationInteractor> {
        self { LocationInteractorImpl() as LocationInteractor }.scope(.singleton)
    }
}

