//
//  MainMenuView.swift
//  iOSDriverApp
//

import SwiftUI

// MARK: - Menu Item Model
struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let color: [String]
    let destination: AnyView
}

// MARK: - Main Menu View
struct MainMenuView: View {

    private let menuItems: [MenuItem] = [
        MenuItem(
            title: "Dashboard",
            subtitle: "Vista general del sistema",
            icon: "gauge.with.dots.needle.bottom.50percent",
            color: ["4facfe", "00f2fe"],
            destination: AnyView(DashboardView())
        ),
        MenuItem(
            title: "Perfil",
            subtitle: "Información del usuario",
            icon: "person.crop.circle.fill",
            color: ["a18cd1", "fbc2eb"],
            destination: AnyView(ProfileView())
        ),
        MenuItem(
            title: "Ajustes",
            subtitle: "Configuración de la app",
            icon: "gearshape.2.fill",
            color: ["f093fb", "f5576c"],
            destination: AnyView(SettingsView())
        ),
        MenuItem(
            title: "Debug Info",
            subtitle: "Información del dispositivo y sistema",
            icon: "ant.fill",
            color: ["43e97b", "38f9d7"],
            destination: AnyView(DebugView())
        ),
        MenuItem(
            title: "Acerca de",
            subtitle: "Versión y licencias",
            icon: "info.circle.fill",
            color: ["f7971e", "ffd200"],
            destination: AnyView(AboutView())
        ),
    ]

    var body: some View {
        ZStack {
            // Background
            Color(hex: "0d0d1a")
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    headerSection

                    // Menu items
                    LazyVStack(spacing: 14) {
                        ForEach(menuItems) { item in
                            NavigationLink(destination: item.destination) {
                                MenuCardView(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Bienvenido")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.5))

                    Text("iOSDriverApp")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }

                Spacer()

                Image(systemName: "car.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "e94560"), Color(hex: "f5a623")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .padding(.bottom, 24)
        }
    }
}

// MARK: - Menu Card View
struct MenuCardView: View {
    let item: MenuItem
    @State private var isPressed = false

    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: item.color.map { Color(hex: $0) },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 52, height: 52)
                    .shadow(
                        color: Color(hex: item.color[0]).opacity(0.4),
                        radius: 8, x: 0, y: 4
                    )

                Image(systemName: item.icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
            }

            // Text
            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)

                Text(item.subtitle)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color.white.opacity(0.45))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(Color.white.opacity(0.25))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
        )
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
        .onTapGesture {} // handled by NavigationLink
        .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}

#Preview {
    NavigationStack {
        MainMenuView()
    }
}
