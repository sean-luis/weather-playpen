import FactoryKit

extension Container {
    var module: Factory<WPPModule> {
        self { WPPModuleImpl() as WPPModule }
    }
}

