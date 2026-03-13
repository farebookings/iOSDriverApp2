//
//  WelcomeView.swift
//  iOSDriverApp
//

import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcome: Bool

    @State private var logoScale: CGFloat = 0.3
    @State private var logoOpacity: Double = 0
    @State private var titleOpacity: Double = 0
    @State private var subtitleOpacity: Double = 0
    @State private var progressValue: CGFloat = 0

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(hex: "1a1a2e"), Color(hex: "16213e"), Color(hex: "0f3460")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // Logo / Icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "e94560"), Color(hex: "f5a623")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 120, height: 120)
                        .shadow(color: Color(hex: "e94560").opacity(0.6), radius: 20, x: 0, y: 0)

                    Image(systemName: "car.fill")
                        .font(.system(size: 52))
                        .foregroundColor(.white)
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)

                // Title
                VStack(spacing: 8) {
                    Text("iOSDriverApp")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("Test & Development Sandbox")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.6))
                }
                .opacity(titleOpacity)

                // Subtitle / version
                VStack(spacing: 4) {
                    Text("v1.0.0 · Build 1")
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .foregroundColor(Color.white.opacity(0.4))
                }
                .opacity(subtitleOpacity)

                Spacer()

                // Progress bar
                VStack(spacing: 12) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(0.1))
                            .frame(height: 4)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "e94560"), Color(hex: "f5a623")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: progressValue * UIScreen.main.bounds.width * 0.7, height: 4)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.7)

                    Text("Cargando…")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.4))
                }
                .padding(.bottom, 60)
                .opacity(subtitleOpacity)
            }
        }
        .onAppear {
            startAnimations()
        }
    }

    private func startAnimations() {
        // Logo animation
        withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.2)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }

        // Title fade
        withAnimation(.easeOut(duration: 0.6).delay(0.7)) {
            titleOpacity = 1.0
        }

        // Subtitle + progress
        withAnimation(.easeOut(duration: 0.5).delay(1.0)) {
            subtitleOpacity = 1.0
        }

        // Progress bar
        withAnimation(.easeInOut(duration: 1.8).delay(1.2)) {
            progressValue = 1.0
        }

        // Transition to main menu
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
            withAnimation(.easeInOut(duration: 0.5)) {
                showWelcome = false
            }
        }
    }
}

// MARK: - Color hex extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    WelcomeView(showWelcome: .constant(true))
}
