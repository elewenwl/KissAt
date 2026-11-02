import SwiftUI

struct ContentView: View {
    @StateObject private var vm = SkinViewModel()
    @State private var showPicker = false
    @State private var showPairing = false
    @State private var showInfo = false
    @State private var glow = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            RadialGradient(colors: [.purple.opacity(0.3), .clear], center: .topTrailing, startRadius: 40, endRadius: 500).ignoresSafeArea()
            VStack(spacing: 28) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("KISS").font(.system(size: 11, weight: .medium, design: .monospaced)).tracking(8).foregroundStyle(.purple.opacity(0.7))
                        Text("At").font(.system(size: 36, weight: .thin, design: .rounded)).foregroundStyle(.white)
                    }
                    Spacer()
                    Button { showInfo = true } label: {
                        Image(systemName: "info.circle").font(.system(size: 20, weight: .light)).foregroundStyle(.white.opacity(0.4))
                    }
                }
                .padding(.horizontal, 24).padding(.top, 24)

                ZStack {
                    RoundedRectangle(cornerRadius: 24).fill(.ultraThinMaterial)
                    if let img = vm.selectedImage {
                        Image(uiImage: img).resizable().scaledToFill().clipShape(RoundedRectangle(cornerRadius: 24))
                    } else {
                        Image(systemName: "photo.artframe").font(.system(size: 40, weight: .ultraLight)).foregroundStyle(.white.opacity(0.25))
                    }
                }
                .frame(height: 250).padding(.horizontal, 24)
                .shadow(color: .purple.opacity(glow ? 0.25 : 0.05), radius: 24)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: glow)
                .onAppear { glow = true }

                Text(vm.statusMessage).font(.system(size: 11, weight: .medium, design: .monospaced)).foregroundStyle(.white.opacity(0.5))
                    .padding(.horizontal, 14).padding(.vertical, 7).background(.ultraThinMaterial, in: Capsule())

                Spacer()

                HStack(spacing: 12) {
                    Button { showPairing = true } label: {
                        Image(systemName: "link").font(.system(size: 16, weight: .medium)).frame(width: 52, height: 52)
                    }.buttonStyle(.bordered).tint(.white.opacity(0.5))

                    Button { showPicker = true } label: {
                        Label("Pick", systemImage: "photo").font(.system(size: 15, weight: .medium)).frame(maxWidth: .infinity).frame(height: 52)
                    }.buttonStyle(.bordered).tint(.white.opacity(0.6))

                    Button { vm.apply() } label: {
                        Label("Flash", systemImage: "bolt.fill").font(.system(size: 15, weight: .semibold)).frame(maxWidth: .infinity).frame(height: 52)
                    }.buttonStyle(.borderedProminent).tint(.purple)
                        .disabled(vm.selectedImage == nil || vm.isBusy || !vm.pairingLoaded)
                }
                .padding(.horizontal, 24).padding(.bottom, 28)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showPicker) { ImagePicker(image: $vm.selectedImage) }
        .sheet(isPresented: $showPairing) { PairingPicker { url in vm.importPairing(from: url) } }
        .sheet(isPresented: $showInfo) { DeviceInfoView() }
    }
}

struct PairingPicker: UIViewControllerRepresentable {
    let onPick: (URL) -> Void
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let p = UIDocumentPickerViewController(forOpeningContentTypes: [.data])
        p.delegate = context.coordinator
        return p
    }
    func updateUIViewController(_ vc: UIDocumentPickerViewController, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: PairingPicker
        init(_ p: PairingPicker) { parent = p }
        func documentPicker(_ c: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let u = urls.first { parent.onPick(u) }
        }
    }
}
