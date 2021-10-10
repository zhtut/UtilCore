//
//  File.swift
//  
//
//  Created by shutut on 2021/10/10.
//

import Foundation
import COpenSSL

public let HMAC_SHA256_LENGTH = 32
public let HMAC_SHA512_LENGTH = 64

public extension Data {
    var bytes: [UInt8] {
        return [UInt8](self)
    }
}

public extension Array where Element == UInt8 {
    var data: Data {
        return Data(self)
    }
}

public extension String {
    func hmacToBase64StringWith(key: String) -> String {
        let result = hmacWith(key: key)
        let base64String = result.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    func hmacWith(key: String) -> Data {
        if let ckey = key.data(using: .utf8),
           let cData = self.data(using: .utf8) {
            var digest = Data(repeating: 0, count: HMAC_SHA256_LENGTH)
            digest.withUnsafeMutableBytes { digestPtr in
                cData.withUnsafeBytes { dataPtr in
                    ckey.withUnsafeBytes { keyPtr in
                        _ = HMAC(EVP_sha256(), keyPtr, Int32(key.count), dataPtr, cData.count, digestPtr, nil)
                    }
                }
            }
            return digest
        }
        return Data()
    }
    
    func hmacWithSha512(key: String) -> Data {
        if let ckey = key.data(using: .utf8),
           let cData = self.data(using: .utf8) {
            var digest = Data(repeating: 0, count: HMAC_SHA512_LENGTH)
            digest.withUnsafeMutableBytes { digestPtr in
                cData.withUnsafeBytes { dataPtr in
                    ckey.withUnsafeBytes { keyPtr in
                        _ = HMAC(EVP_sha512(), keyPtr, Int32(key.count), dataPtr, cData.count, digestPtr, nil)
                    }
                }
            }
            return digest
        }
        return Data()
    }
    
    func hmacToSha256StringWith(key: String) -> String {
        var result = hmacWith(key: key)
        var str: String?
        let length = result.count
        result.withUnsafeMutableBytes { bufferPointer in
            str = stringFromResult(result: bufferPointer, length: length)
        }
        return str ?? ""
    }
    
    func sha512() -> String {
        if let data = self.data(using: .utf8) {
            let bytes = data.bytes
            var digest = Data(repeating: 0, count: HMAC_SHA512_LENGTH)
            digest.withUnsafeMutableBytes { pointer in
                SHA512(bytes, bytes.count, pointer)
            }
            var str: String?
            let length = digest.count
            digest.withUnsafeMutableBytes { bufferPointer in
                str = stringFromResult(result: bufferPointer, length: length)
            }
            return str ?? ""
        }
        return ""
    }
    
    func hmacToSha512StringWith(key: String) -> String {
        var result = hmacWithSha512(key: key)
        var str: String?
        let length = result.count
        result.withUnsafeMutableBytes { bufferPointer in
            str = stringFromResult(result: bufferPointer, length: length)
        }
        return str ?? ""
    }
    
    private func stringFromResult(result: UnsafeMutableRawPointer, length: Int) -> String {
        let hash = NSMutableString(capacity: length)
        var pointer = result
        for _ in 0..<length {
            let x = pointer.load(as: UInt8.self)
            hash.append(String(format: "%02x", x))
            pointer = pointer + 1
        }
        return "\(hash)".lowercased()
    }
}
