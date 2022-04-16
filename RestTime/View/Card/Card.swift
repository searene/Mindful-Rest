//
//  Card.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/10.
//

import SwiftUI

enum CardPos {
    case middle, bottom
}

struct Card<Content: View>: View {

    let content: Content
    @Binding var cardShown: Bool
    var cardPos: CardPos
    let tapElsewhereToDismiss: Bool

    init(cardShown: Binding<Bool>,
         cardPos: CardPos,
         tapElsewhereToDismiss: Bool,
         @ViewBuilder content: () -> Content) {
            _cardShown = cardShown
            self.cardPos = cardPos
            self.tapElsewhereToDismiss = tapElsewhereToDismiss
            self.content = content()
         }
    
    var body: some View {
        ZStack {
            GeometryReader() {_ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(cardShown ? 1 : 0)
            .onTapGesture {
                if tapElsewhereToDismiss {
                    self.dismiss()
                }
            }
            
            if cardShown {
                VStack {
                    Spacer()
                    
                    VStack {
                        
                        content
                    }
                    .background(Color.white)
                    
                    if cardPos == .middle {
                        Spacer()
                    }
                }
            }
        }
    }

    private func dismiss() {
        withAnimation {
            cardShown = false
        }
    }
}

struct CardContent: View {
    var body: some View {
        VStack {
            Button("Modify", action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Button("Delete", role: .destructive, action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Divider()
            
            Button("Cancel", action: {})
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
}

struct Card_Previews: PreviewProvider {
    
    @State private static var cardShown = true
    
    static var previews: some View {
        TabView {
            Card(cardShown: $cardShown,
                       cardPos: .bottom,
                       tapElsewhereToDismiss: true) {
                CardContent()
                    .padding()
            }
            .tabItem {
                Label("Menu", systemImage: "list.dash")
            }
        }
    }
    
}
