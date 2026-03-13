//
//  SettingsView.swift
//  iOSDriverApp
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = true
    @State private var locationEnabled = false
    @State private var analyticsEnabled = false
    @State private var selectedLanguage = "Español"

    private let languages = ["Español", "English", "Français", "Deutsch"]

    var body: some View {
        ZStack {
            Color(hex: "0d0d1a").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // General section
                    SettingsSectionView(title: "General") {
                        SettingsToggleRow(icon: "bell.fill", iconColor: "e94560", title: "Notificaciones", isOn: $notificationsEnabled)
                        SettingsToggleRow(icon: "moon.fill", iconColor: "a18cd1", title: "Modo oscuro", isOn: $darkModeEnabled)

                        HStack {
                            Label {
                                Text("Idioma")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.white)
                            } icon: {
                                Image(systemName: "globe")
                                    .foregroundColor(Color(hex: "4facfe"))
                                    .frame(width: 28, height: 28)
                            }
                            Spacer()
                            Picker("", selection: $selectedLanguage) {
                                ForEach(languages, id: \.self) { lang in
                                    Text(lang).tag(lang)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(Color(hex: "4facfe"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }

                    // Privacy section
                    SettingsSectionView(title: "Privacidad") {
                        SettingsToggleRow(icon: "location.fill", iconColor: "43e97b", title: "Ubicación", isOn: $locationEnabled)
                        SettingsToggleRow(icon: "chart.bar.fill", iconColor: "f5a623", title: "Analíticas", isOn: $analyticsEnabled)
                    }

                    // App info
                    SettingsSectionView(title: "Aplicación") {
                        SettingsInfoRow(icon: "tag.fill", iconColor: "fbc2eb", title: "Versión", value: "1.0.0")
                        SettingsInfoRow(icon: "hammer.fill", iconColor: "f5a623", title: "Build", value: "1")
                        SettingsInfoRow(icon: "swift", iconColor: "f05138", title: "Swift", value: "5.9")
                    }

                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
        }
        .navigationTitle("Ajustes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

// MARK: - Subcomponents
struct SettingsSectionView<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(Color.white.opacity(0.35))
                .padding(.leading, 4)
                .padding(.bottom, 8)

            VStack(spacing: 0) {
                content()
            }
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.white.opacity(0.07), lineWidth: 1)
            )
        }
    }
}

struct SettingsToggleRow: View {
    let icon: String
    let iconColor: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            Label {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
            } icon: {
                Image(systemName: icon)
                    .foregroundColor(Color(hex: iconColor))
                    .frame(width: 28, height: 28)
            }
        }
        .tint(Color(hex: iconColor))
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .overlay(
            Rectangle().fill(Color.white.opacity(0.05)).frame(height: 1), alignment: .bottom
        )
    }
}

struct SettingsInfoRow: View {
    let icon: String
    let iconColor: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Label {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
            } icon: {
                Image(systemName: icon)
                    .foregroundColor(Color(hex: iconColor))
                    .frame(width: 28, height: 28)
            }
            Spacer()
            Text(value)
                .font(.system(size: 14))
                .foregroundColor(Color.white.opacity(0.4))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .overlay(
            Rectangle().fill(Color.white.opacity(0.05)).frame(height: 1), alignment: .bottom
        )
    }
}

#Preview {
    NavigationStack { SettingsView() }
}
