import FactoryKit

extension Container {
    public var locationInteractor: Factory<LocationInteractor> {
        self { LocationInteractorImpl() as LocationInteractor }
    }
}

