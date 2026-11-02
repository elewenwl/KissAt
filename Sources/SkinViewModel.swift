import SwiftUI
import Combine

final class SkinViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var statusMessage = "Import pairing file"
    @Published var isBusy = false
    @Published var pairingLoaded = false

    func importPairing(from url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            statusMessage = "Access denied"
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        let dest = FileManager.default.temporaryDirectory
            .appendingPathComponent("pairing.mobiledevicepairing")
        try? FileManager.default.removeItem(at: dest)
        do {
            try FileManager.default.copyItem(at: url, to: dest)
            AirliftBridge.shared.pairingPath = dest.path
            AirliftBridge.shared.configureHost()
            pairingLoaded = true
            statusMessage = "Pairing loaded"
        } catch {
            statusMessage = error.localizedDescription
        }
    }

    func apply() {
        guard let img = selectedImage, let data = img.pngData() else {
            statusMessage = "Pick an image"
            return
        }
        guard pairingLoaded else {
            statusMessage = "Pairing required"
            return
        }
        isBusy = true
        statusMessage = "Preparing..."
        let fm = FileManager.default
        let dir = fm.temporaryDirectory.appendingPathComponent("payload", isDirectory: true)
        try? fm.removeItem(at: dir)
        try? fm.createDirectory(at: dir, withIntermediateDirectories: true)
        let file = dir.appendingPathComponent("cardBackgroundCombined@3x.png")
        do {
            try data.write(to: file)
        } catch {
            isBusy = false
            statusMessage = error.localizedDescription
            return
        }
        let target = "/var/mobile/Library/Caches/Passbook"
        DispatchQueue.global(qos: .userInitiated).async {
            let err = AirliftBridge.shared.writeDirectory(sourceDir: dir.path, targetDir: target)
            DispatchQueue.main.async {
                self.isBusy = false
                if let err = err {
                    self.statusMessage = err
                } else {
                    self.statusMessage = "Flashing..."
                    DispatchQueue.global(qos: .userInitiated).async {
                        let rErr = AirliftBridge.shared.respring()
                        DispatchQueue.main.async {
                            self.statusMessage = rErr == nil ? "Done" : (rErr ?? "Respring failed")
                        }
                    }
                }
            }
        }
    }
}
