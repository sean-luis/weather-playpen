import FactoryKit

extension Container {
    @MainActor
    public var repository: Factory<Repository> {
        self { @MainActor in RepositoryImpl() as Repository }
    }
    
    public var networkingProvider: Factory<NetworkingProvider> {
        self { NetworkingProviderImpl() as NetworkingProvider }
    }
    
    public var locationInteractor: Factory<LocationInteractor> {
        self { LocationInteractorImpl() as LocationInteractor }
    }
}

