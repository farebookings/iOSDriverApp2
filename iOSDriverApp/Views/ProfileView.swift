//
//  ProfileView.swift
//  iOSDriverApp
//

import SwiftUI

struct ProfileView: View {
    private let details: [(String, String, String)] = [
        ("Nombre", "Usuario Prueba", "person.fill"),
        ("Email", "test@example.com", "envelope.fill"),
        ("Rol", "Driver / Tester", "car.fill"),
        ("ID", "#USR-001", "number"),
        ("Región", "Madrid, ESP", "map.fill"),
    ]

    var body: some View {
        ZStack {
            Color(hex: "0d0d1a").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // Avatar
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "a18cd1"), Color(hex: "fbc2eb")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 90, height: 90)
                            .shadow(color: Color(hex: "a18cd1").opacity(0.5), radius: 15)

                        Text("UT")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)

                    Text("Usuario Prueba")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)

                    // Detail rows
                    VStack(spacing: 2) {
                        ForEach(details, id: \.0) { detail in
                            ProfileRowView(icon: detail.2, label: detail.0, value: detail.1)
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 30)
                }
            }
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct ProfileRowView: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "a18cd1"))
                .frame(width: 20)

            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color.white.opacity(0.5))
                .frame(width: 70, alignment: .leading)

            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color.white.opacity(0.04))
        .overlay(
            Rectangle()
                .fill(Color.white.opacity(0.06))
                .frame(height: 1),
            alignment: .bottom
        )
    }
}

#Preview {
    NavigationStack { ProfileView() }
}
