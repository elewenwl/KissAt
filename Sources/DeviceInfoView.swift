import SwiftUI

struct DeviceInfoView: View {
    @Environment(\.dismiss) private var dismiss
    private let items = DeviceInfo.collect()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                List {
                    Section {
                        ForEach(items, id: \.0) { key, value in
                            HStack {
                                Text(key).font(.system(size: 13, weight: .medium, design: .monospaced)).foregroundStyle(.white.opacity(0.5))
                                Spacer()
                                Text(value).font(.system(size: 13, design: .monospaced)).foregroundStyle(.white)
                            }
                            .listRowBackground(Color.white.opacity(0.04))
                        }
                    } header: {
                        Text("DEVICE").font(.system(size: 10, weight: .semibold, design: .monospaced)).tracking(3).foregroundStyle(.purple.opacity(0.7))
                    }
                    Section {
                        Link(destination: URL(string: "https://github.com/elewenwl")!) {
                            HStack {
                                Text("Author").font(.system(size: 13, weight: .medium, design: .monospaced)).foregroundStyle(.white.opacity(0.5))
                                Spacer()
                                Text("elewenwl").font(.system(size: 13, design: .monospaced)).foregroundStyle(.purple)
                                Image(systemName: "arrow.up.right").font(.system(size: 10)).foregroundStyle(.purple.opacity(0.6))
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.04))
                    } header: {
                        Text("ABOUT").font(.system(size: 10, weight: .semibold, design: .monospaced)).tracking(3).foregroundStyle(.purple.opacity(0.7))
                    }
                }
                .scrollContentBackground(.hidden).listStyle(.insetGrouped)
            }
            .navigationTitle("KissAt").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }.tint(.purple)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
