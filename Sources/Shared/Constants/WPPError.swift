import Foundation

public enum WPPError: Error {
    case decodingFailure(decodingError: DecodingError)
    case requestFailure(urlError: URLError)
    case statusCodeFailure(statusCode: Int)
    case defaultWPPError(error: NSError)
}
