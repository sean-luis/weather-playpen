import SwiftUI

/*
 Credit to Rishabh Sharma: https://medium.com/@rishixcode/shimmer-effect-in-swiftui-a0d0a1dd586a
 Modified by Sean Gomes-Luis
 */

extension View {
    @ViewBuilder
    func shimmer(_ state: Binding<ViewState> = .constant(.ready)) -> some View {
        switch state.wrappedValue {
        case .loading:
            self
                .redactable()
        default:
            self
        }
    }
    
    func redactable() -> some View {
        modifier(Redactable())
    }
}

struct Redactable: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        content.overlay {
            ShimmerView()
                .mask(content)
        }
        .redacted(reason: .placeholder)
    }
}

struct ShimmerView: View {
    @State private var moveToRight = false
    
    var body: some View {
        GeometryReader { proxy in
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.gray, Color.black, Color.gray, Color.clear]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .offset(x: self.moveToRight ? proxy.size.width : -proxy.size.width)
                .task { @MainActor in
                    moveToRight = true
                }
                .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: moveToRight)
            
        }
    }
}
