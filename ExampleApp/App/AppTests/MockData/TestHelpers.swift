import Foundation

final class TestHelpers {
    public static let bundle = Bundle(for: TestHelpers.self)

    public static func decodeJsonObject<T: Codable>(ofType: T.Type, from jsonFileName: String, in bundle: Bundle) -> T? {
        guard let jsonFilePath = bundle.url(forResource: jsonFileName, withExtension: "json")?.path else {
            return nil
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFilePath)) else {
            return nil
        }

        do {
            let decodedData: T = try JSONDecoder().decode(T.self, from: data)
            return decodedData as T
        } catch {
            return nil
        }
    }
}
