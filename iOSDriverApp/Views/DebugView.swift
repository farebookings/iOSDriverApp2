//
//  DebugView.swift
//  iOSDriverApp
//

import SwiftUI
import UIKit

struct DebugView: View {
    private var debugInfo: [(String, String, String)] {
        let device = UIDevice.current
        let screen = UIScreen.main
        return [
            ("Dispositivo", device.model, "iphone"),
            ("Sistema", "\(device.systemName) \(device.systemVersion)", "memorychip"),
            ("Nombre", device.name, "person.text.rectangle"),
            ("Batería", device.isBatteryMonitoringEnabled ? "\(Int(device.batteryLevel * 100))%" : "N/A", "battery.75"),
            ("Orientación", orientationName(device.orientation), "rotate.right"),
            ("Pantalla", "\(Int(screen.bounds.width)) × \(Int(screen.bounds.height)) pt", "aspectratio"),
            ("Escala", "\(Int(screen.scale))x", "magnifyingglass"),
            ("Idioma", Locale.current.identifier, "globe"),
            ("Bundle ID", Bundle.main.bundleIdentifier ?? "N/A", "cube"),
            ("Build", Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A", "hammer"),
            ("Versión", Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A", "tag"),
        ]
    }

    @State private var copiedRow: String? = nil

    var body: some View {
        ZStack {
            Color(hex: "0d0d1a").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 2) {
                    ForEach(debugInfo, id: \.0) { item in
                        DebugRowView(icon: item.2, label: item.0, value: item.1, copied: copiedRow == item.0) {
                            UIPasteboard.general.string = item.1
                            copiedRow = item.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                copiedRow = nil
                            }
                        }
                    }
                }
                .background(Color.white.opacity(0.04))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white.opacity(0.07), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .padding(.top, 10)
        }
        .navigationTitle("Debug Info")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            UIDevice.current.isBatteryMonitoringEnabled = true
        }
    }

    private func orientationName(_ orientation: UIDeviceOrientation) -> String {
        switch orientation {
        case .portrait: return "Portrait"
        case .portraitUpsideDown: return "Portrait ↕"
        case .landscapeLeft: return "Landscape L"
        case .landscapeRight: return "Landscape R"
        case .faceUp: return "Face Up"
        case .faceDown: return "Face Down"
        default: return "Desconocida"
        }
    }
}

struct DebugRowView: View {
    let icon: String
    let label: String
    let value: String
    let copied: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "43e97b"))
                    .frame(width: 20)

                Text(label)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color.white.opacity(0.5))
                    .frame(width: 90, alignment: .leading)

                Text(value)
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    .foregroundColor(.white)
                    .lineLimit(1)

                Spacer()

                Image(systemName: copied ? "checkmark" : "doc.on.doc")
                    .font(.system(size: 11))
                    .foregroundColor(copied ? Color(hex: "43e97b") : Color.white.opacity(0.2))
                    .animation(.easeInOut(duration: 0.2), value: copied)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .overlay(
                Rectangle().fill(Color.white.opacity(0.05)).frame(height: 1), alignment: .bottom
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack { DebugView() }
}
