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
            return .yellow
        case .naver:
            return .green
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
            return Image(systemName: "message.fill")
        case .naver:
            return Image(systemName: "n.square.fill")
        case .google:
            return Image(systemName: "g.circle")
        case .apple:
            return Image(systemName: "applelogo")
        case .email:
            return Image(systemName: "")
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
                .offset(x: 10)
        }
    }
}

public extension ButtonStyle where Self == SignButtonStyle {
    static func signButton(type: SignType) -> Self {
        return .init(signType: type)
    }
}

