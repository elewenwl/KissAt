import UIKit

struct DeviceInfo {
    static func collect() -> [(String, String)] {
        let d = UIDevice.current
        var items: [(String, String)] = []
        items.append(("Device Name", d.name))
        items.append(("Model", d.model))
        items.append(("System", "\(d.systemName) \(d.systemVersion)"))
        items.append(("Identifier", d.identifierForVendor?.uuidString ?? "—"))
        items.append(("Machine", machineIdentifier()))
        items.append(("CPU Cores", "\(ProcessInfo.processInfo.processorCount)"))
        items.append(("Physical Memory", memoryString()))
        return items
    }

    private static func machineIdentifier() -> String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }

    private static func memoryString() -> String {
        let bytes = ProcessInfo.processInfo.physicalMemory
        return String(format: "%.1f GB", Double(bytes) / 1_073_741_824)
    }
}
