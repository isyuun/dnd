import SwiftUI

struct RectButtonModifier: ViewModifier {
    var textColor: Color
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(textColor)
            Spacer()
        }
    }
}

public struct RectPrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(RectButtonModifier(textColor: .white))
            .frame(height: 48)
            .background(
            isEnabled ? Color.primary : Color.gray
        )
            .overlay(
            Color.black
                .opacity(configuration.isPressed ? 0.1 : 0)
        )
            .cornerRadius(5)
    }
}

public extension ButtonStyle where Self == RectPrimaryButtonStyle {
    static var rectPrimary: Self { return .init() }
}

public struct RectSecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(RectButtonModifier(textColor: .gray))
            .frame(height: 48)
            .overlay(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.gray, lineWidth: 1.5)
        )
            .overlay(
            Color.white
                .opacity(configuration.isPressed ? 0.5 : 0)
        )
    }
}

public extension ButtonStyle where Self == RectSecondaryButtonStyle {
    static var rectSecondary: Self { return .init() }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0) // Invalid hex string, default to white color
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

public enum SignType {
    case kakao
    case naver
    case google
    case apple
    case email

    var textColor: Color {
        switch self {
        case .kakao, .google:
            return .black
        case .naver, .apple, .email:
            return .white
        }
    }

    var backGroundColor: Color {
        switch self {
        case .kakao:
            // return .yellow
            return Color(hex: "#F2E367")
        case .naver:
            // return .green
            return Color(hex: "#59C164")
        case .google:
            return .white
        case .apple:
            return .black
        case .email:
            return .blue
        }
    }

    var logoImage: Image {
        switch self {
        case .kakao:
            // return Image(systemName: "message.fill")
            return Image("icon_kakao")
        case .naver:
            // return Image(systemName: "n.square.fill")
            return Image("icon_naver")
        case .google:
            // return Image(systemName: "g.circle")
            return Image("icon_google")
        case .apple:
            // return Image(systemName: "applelogo")
            return Image("icon_apple")
        case .email:
            return Image("")
        }
    }
}

public struct SignButtonStyle: ButtonStyle {
    var signType: SignType
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            configuration.label
                .modifier(RectButtonModifier(textColor: signType.textColor))
                .frame(height: 48)
                .background(
                Group {
                    switch signType {
                    case .google:
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.gray, lineWidth: 1.5)
                    default:
                        signType.backGroundColor
                    }
                }
            )
                .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.5 : 0)
            )
                .cornerRadius(10)

            signType.logoImage
                .foregroundColor(signType.textColor)
                .offset(x: 30)
        }
    }
}

public extension ButtonStyle where Self == SignButtonStyle {
    static func signButton(type: SignType) -> Self {
        return .init(signType: type)
    }
}

