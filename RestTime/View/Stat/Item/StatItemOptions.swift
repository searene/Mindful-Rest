//
//  StatItemOptions.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/10.
//

import SwiftUI

struct StatItemOptions: View {
    
    private let dismissHandler: () -> Void
    private let deleteHandler: () -> Void
    private let modifyHandler: () -> Void
    @State private var showDeleteAlert = false
    
    init(dismissHandler: @escaping () -> Void,
         deleteHandler: @escaping () -> Void,
         modifyHandler: @escaping () -> Void) {
        self.dismissHandler = dismissHandler
        self.deleteHandler = deleteHandler
        self.modifyHandler = modifyHandler
    }
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    self.dismissHandler()
                    self.modifyHandler()
                }
            }) {
                Text("Modify")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            Button(action: {
                showDeleteAlert = true
            }) {
                Text("Delete")
                    .foregroundColor(Color.red)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            Divider()
            
            Button(action: {
                self.dismissHandler()
            }) {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text(""),
                message: Text("This will delete the current record."),
                primaryButton: .destructive(Text("Delete")) {
                    withAnimation {
                        self.deleteHandler()
                        self.dismissHandler()
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct StatItemOptions_Previews: PreviewProvider {
    static var previews: some View {
        StatItemOptions(dismissHandler: {}, deleteHandler: {}, modifyHandler: {})
    }
}
