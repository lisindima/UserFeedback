import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct UserFeedbackModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    ContentView()
                        .ignoresSafeArea(edges: .bottom)
                        .navigationTitle("Сообщение об ошибке")
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button(action: { isPresented = false }) {
                                    Text("Закрыть")
                                }
                            }
                        }
                }
            }
    }
}

public extension View {
    func userFeedback(isPresented: Binding<Bool>) -> some View {
        modifier(UserFeedbackModifier(isPresented: isPresented))
    }
}
