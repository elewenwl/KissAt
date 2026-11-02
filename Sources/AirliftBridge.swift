import Foundation

typealias ALLogCallback = @convention(c) (UnsafeMutableRawPointer?, UnsafePointer<CChar>?) -> Void

@_silgen_name("al_set_target_host")
func al_set_target_host(_ host: UnsafePointer<CChar>?) -> Int32

@_silgen_name("al_exploit_write_dir")
func al_exploit_write_dir(_ pairing_path: UnsafePointer<CChar>?,
                          _ source_dir: UnsafePointer<CChar>?,
                          _ target_dir: UnsafePointer<CChar>?,
                          _ log_cb: ALLogCallback?,
                          _ ctx: UnsafeMutableRawPointer?,
                          _ out_error: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?) -> Int32

@_silgen_name("al_device_respring")
func al_device_respring(_ pairing_path: UnsafePointer<CChar>?,
                        _ log_cb: ALLogCallback?,
                        _ ctx: UnsafeMutableRawPointer?,
                        _ out_error: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?) -> Int32

@_silgen_name("al_string_free")
func al_string_free(_ p: UnsafeMutablePointer<CChar>?)

final class AirliftBridge {
    static let shared = AirliftBridge()
    private init() {}
    var pairingPath: String?

    func configureHost() {
        _ = al_set_target_host("10.7.0.1")
    }

    func writeDirectory(sourceDir: String, targetDir: String) -> String? {
        guard let pairing = pairingPath else { return "No pairing" }
        var errPtr: UnsafeMutablePointer<CChar>? = nil
        let r = pairing.withCString { p in
            sourceDir.withCString { s in
                targetDir.withCString { t in
                    al_exploit_write_dir(p, s, t, nil, nil, &errPtr)
                }
            }
        }
        defer { if let e = errPtr { al_string_free(e) } }
        if r == 0 { return nil }
        return errPtr.map { String(cString: $0) } ?? "Unknown error"
    }

    func respring() -> String? {
        guard let pairing = pairingPath else { return "No pairing" }
        var errPtr: UnsafeMutablePointer<CChar>? = nil
        let r = pairing.withCString { p in
            al_device_respring(p, nil, nil, &errPtr)
        }
        defer { if let e = errPtr { al_string_free(e) } }
        if r == 0 { return nil }
        return errPtr.map { String(cString: $0) } ?? "Unknown error"
    }
}
