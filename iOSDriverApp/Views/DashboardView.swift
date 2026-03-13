//
//  DashboardView.swift
//  iOSDriverApp
//

import SwiftUI

struct DashboardView: View {
    private let stats: [(String, String, String, String)] = [
        ("Batería", "87%", "battery.75", "43e97b"),
        ("Velocidad", "0 km/h", "speedometer", "4facfe"),
        ("Temperatura", "22 °C", "thermometer.medium", "f5a623"),
        ("GPS", "Activo", "location.fill", "e94560"),
    ]

    var body: some View {
        ZStack {
            Color(hex: "0d0d1a").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Stats grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                        ForEach(stats, id: \.0) { stat in
                            StatCardView(title: stat.0, value: stat.1, icon: stat.2, colorHex: stat.3)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    // Placeholder map area
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white.opacity(0.06))
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
                            )

                        VStack(spacing: 10) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color.white.opacity(0.2))
                            Text("Mapa / Área de trabajo")
                                .font(.system(size: 14))
                                .foregroundColor(Color.white.opacity(0.3))
                        }
                    }
                    .frame(height: 200)
                    .padding(.horizontal, 20)

                    Spacer(minLength: 30)
                }
                .padding(.top, 10)
            }
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct StatCardView: View {
    let title: String
    let value: String
    let icon: String
    let colorHex: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(hex: colorHex))

            Spacer()

            Text(value)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.white)

            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.white.opacity(0.45))
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(hex: colorHex).opacity(0.2), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack { DashboardView() }
}
