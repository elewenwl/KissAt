import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var vm = SkinViewModel()
    @State private var showPicker = false
    @State private var showPairing = false
    @State private var showLog = false
    @State private var showTendies = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        HStack {
                            Text("Swiss Knife")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "globe")
                                .foregroundStyle(.blue)
                                .font(.title2)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("by Wepron tg @iosfreedom")
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 16) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 80, height: 100)
                                    .overlay(
                                        Image(systemName: "iphone")
                                            .font(.largeTitle)
                                            .foregroundStyle(.gray)
                                    )
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Определение устройства")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("iOS 27.0.0")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                    
                                    Text("AirLift\niOS 18.0 – 27.2 beta 2")
                                        .font(.caption)
                                        .foregroundStyle(.blue)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                }
                            }
                            Divider().background(Color.gray.opacity(0.3))
                            HStack {
                                Text("Сменить цвет и модель")
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.gray)
                            }
                            .font(.subheadline)
                        }
                        .padding()
                        .background(Color(white: 0.1))
                        .cornerRadius(16)
                        .padding(.horizontal)

                        SectionHeader(title: "Движок эксплойта", icon: "cpu")
                        
                        Button(action: { 
                            vm.statusMessage = "AirLift Engine Ready"
                        }) {
                            Text("Airlift")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)

                        SectionHeader(title: "Сетевой туннель & Сопряжение", icon: "network")
                        
                        VStack(spacing: 0) {
                            StatusRow(icon: "wifi", iconColor: .green, title: "Wi-Fi сеть подключена", subtitle: "Беспроводной интерфейс доступен", statusColor: .green)
                            Divider().background(Color.gray.opacity(0.3)).padding(.leading, 50)
                            
                            StatusRow(icon: "exclamationmark.shield.fill", iconColor: .orange, title: "Local Dev VPN отключен", subtitle: "Включите подсеть 10.7.x.x", statusColor: .orange)
                            
                            Divider().background(Color.gray.opacity(0.3)).padding(.leading, 16)
                            
                            Button(action: { 
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "shield.fill")
                                    Text("Открыть LocalDevVPN")
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                }
                                .foregroundStyle(.orange)
                                .padding()
                                .background(Color.orange.opacity(0.1))
                                .cornerRadius(12)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            
                            StatusRow(icon: "arrow.triangle.2.circlepath", iconColor: .orange, title: "Ожидание Local Dev VPN...", subtitle: "Включите подсеть 10.7.x.x для проверки", statusColor: .orange)
                            
                            Divider().background(Color.gray.opacity(0.3)).padding(.leading, 50)
                            
                            Button(action: { showPairing = true }) {
                                HStack {
                                    Image(systemName: "link.circle.fill").foregroundStyle(.blue)
                                    Text("Управление сопряжением").foregroundStyle(.white)
                                    Spacer()
                                    if vm.pairingLoaded {
                                        Text("Загружено").foregroundStyle(.green).font(.caption)
                                    } else {
                                        Image(systemName: "chevron.right").foregroundStyle(.gray)
                                    }
                                }
                                .padding()
                            }
                        }
                        .background(Color(white: 0.1))
                        .cornerRadius(16)
                        .padding(.horizontal)

                        SectionHeader(title: "Код-пароль", icon: "lock.shield")
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "circle.grid.3x3.fill").foregroundStyle(.blue)
                                VStack(alignment: .leading) {
                                    Text("Темы экрана пароля").foregroundStyle(.white).font(.headline)
                                    Text("Создавайте свой стиль кнопок код-пароля").foregroundStyle(.gray).font(.caption)
                                }
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.gray)
                            }
                            .padding()
                            .background(Color(white: 0.1))
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)

                        SectionHeader(title: "Обои .tendies", icon: "photo.on.rectangle")
                        Button(action: { showPicker = true }) {
                            HStack {
                                Image(systemName: "photo.fill").foregroundStyle(.purple)
                                VStack(alignment: .leading) {
                                    Text("Анимированные обои").foregroundStyle(.white).font(.headline)
                                    Text("Импорт пакетов .tendies и сброс коллекций").foregroundStyle(.gray).font(.caption)
                                }
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.gray)
                            }
                            .padding()
                            .background(Color(white: 0.1))
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)

                        if vm.selectedImage != nil {
                            Button(action: { vm.apply() }) {
                                HStack {
                                    Image(systemName: "bolt.fill")
                                    Text("Применить обои (Flash)")
                                }
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.purple)
                                .cornerRadius(16)
                            }
                            .padding(.horizontal)
                            .disabled(vm.isBusy || !vm.pairingLoaded)
                            .opacity((vm.isBusy || !vm.pairingLoaded) ? 0.5 : 1.0)
                        }
                        
                        SectionHeader(title: "Действия", icon: "arrow.clockwise")
                        Button(action: { 
                            let err = AirliftBridge.shared.respring()
                            if let err = err {
                                vm.statusMessage = err
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise.circle.fill").foregroundStyle(.blue)
                                Text("Быстрый перезапуск (Respring)").foregroundStyle(.blue).font(.headline)
                                Spacer()
                            }
                            .padding()
                            .background(Color(white: 0.1))
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        
                        SectionHeader(title: "Диагностика", icon: "doc.text")
                        Button(action: { showLog = true }) {
                            HStack {
                                Image(systemName: "list.bullet.rectangle").foregroundStyle(.blue)
                                VStack(alignment: .leading) {
                                    Text("Системный журнал").foregroundStyle(.white).font(.headline)
                                    Text("Просмотр и экспорт логов работы приложения").foregroundStyle(.gray).font(.caption)
                                }
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.gray)
                            }
                            .padding()
                            .background(Color(white: 0.1))
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showPicker) {
            ImagePicker(image: $vm.selectedImage)
        }
        .fileImporter(
            isPresented: $showPairing,
            allowedContentTypes: [.data],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first {
                    vm.importPairing(from: url)
                }
            case .failure(let error):
                vm.statusMessage = error.localizedDescription
            }
        }
        .sheet(isPresented: $showLog) {
            Text("Логи пока не реализованы").foregroundStyle(.white).padding()
        }
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(title)
        }
        .font(.subheadline)
        .foregroundStyle(.gray)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct StatusRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let statusColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
                .font(.title2)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title).foregroundStyle(.white).font(.subheadline).bold()
                Text(subtitle).foregroundStyle(.gray).font(.caption)
            }
            Spacer()
            Circle().fill(statusColor).frame(width: 8, height: 8)
        }
        .padding()
    }
}
