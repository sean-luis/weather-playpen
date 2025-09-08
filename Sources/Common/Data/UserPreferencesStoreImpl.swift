import Foundation

final class UserPreferencesStoreImpl: UserPreferencesStore {
    private let userDefaults = UserDefaults.standard
    
    func set<Model: Codable>(object: Model, for key: String) {
        guard let encoded = try? JSONEncoder().encode(object) else {
            return
        }
        userDefaults.set(encoded, forKey: key)
        userDefaults.synchronize()
    }
    
    func retrieveObject<Model: Codable>(type: Model.Type, for key: String) -> Model? {
        guard let savedData = userDefaults.data(forKey: key),
              let decodedObject = try? JSONDecoder().decode(type, from: savedData) else {
            return nil
        }
        return decodedObject
    }
}
