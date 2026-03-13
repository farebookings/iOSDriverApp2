//
//  AboutView.swift
//  iOSDriverApp
//

import SwiftUI

struct AboutView: View {
    private let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    private let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"

    var body: some View {
        ZStack {
            Color(hex: "0d0d1a").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    // App icon area
                    VStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: "e94560"), Color(hex: "f5a623")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 90, height: 90)
                                .shadow(color: Color(hex: "e94560").opacity(0.5), radius: 20)

                            Image(systemName: "car.fill")
                                .font(.system(size: 38))
                                .foregroundColor(.white)
                        }

                        Text("iOSDriverApp")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text("Versión \(version) (\(build))")
                            .font(.system(size: 13))
                            .foregroundColor(Color.white.opacity(0.4))
                    }
                    .padding(.top, 10)

                    // Info section
                    SettingsSectionView(title: "Información") {
                        SettingsInfoRow(icon: "tag.fill",      iconColor: "fbc2eb", title: "Versión",       value: version)
                        SettingsInfoRow(icon: "hammer.fill",   iconColor: "f5a623", title: "Build",         value: build)
                        SettingsInfoRow(icon: "swift",         iconColor: "f05138", title: "Swift",         value: "5.9")
                        SettingsInfoRow(icon: "xcode",         iconColor: "1575f9", title: "Xcode",         value: "16+")
                        SettingsInfoRow(icon: "iphone",        iconColor: "4facfe", title: "iOS mínimo",    value: "17.0")
                    }
                    .padding(.horizontal, 20)

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descripción")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(Color.white.opacity(0.35))
                            .padding(.leading, 4)

                        Text("Aplicación de prueba y desarrollo iOS para validar compilación, navegación y patrones de diseño con SwiftUI.")
                            .font(.system(size: 14))
                            .foregroundColor(Color.white.opacity(0.6))
                            .lineSpacing(5)
                            .padding(16)
                            .background(Color.white.opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.white.opacity(0.07), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 20)

                    Text("Made with ♥ using SwiftUI")
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.25))
                        .padding(.bottom, 30)
                }
            }
        }
        .navigationTitle("Acerca de")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

#Preview {
    NavigationStack { AboutView() }
}
