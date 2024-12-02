//
//  RedoUndo.swift
//  BiRTH
//
//  Created by 이소현 on 11/25/24.
//

import SwiftUI

struct RedoUndo: View {
    @Environment(\.managedObjectContext) private var viewContext
    var undoManager = UndoManager()
    
    var body: some View {
        HStack(spacing: 4) {
            Button {
                print("undo")
                viewContext.undo()
            } label: {
                Image(systemName: "arrow.uturn.left")
                    .foregroundStyle(.black)
            }
            
            Button {
                print("redo")
                viewContext.redo()
            } label: {
                Image(systemName: "arrow.uturn.forward")
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    RedoUndo()
}
