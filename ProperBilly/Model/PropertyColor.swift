import SwiftUI

enum PropertyColor: String, CaseIterable, Codable, Hashable {
    case red
    case orange
    case yellow
    case green
    case blue
    case pink
    case purple

    var color: Color {
        switch self {
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .pink: return .pink
        case .purple: return .purple
        }
    }
}
