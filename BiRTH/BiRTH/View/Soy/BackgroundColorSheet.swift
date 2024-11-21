//
//  BackgroundColorPicker.swift
//  BiRTH
//
//  Created by 이소현 on 11/21/24.
//

import SwiftUI

struct BackgroundColorSheet: View {
    
    let rows = [GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    @State var selectedColor: Color = .white
    @State var colorPicker: Color = .black
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                }
            }
            
            HStack(spacing: 15) {
                LazyHGrid(rows: rows) {
                    ForEach(ColorButton.allCases, id: \.self) { button in
                        Circle()
                            .fill(button.color)
                            .frame(width: 25, height: 25)
                            .overlay {
                                if selectedColor == button.color {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.black)
                                        .bold()
                                } else {
                                    EmptyView()
                                }
                            }
                            .onTapGesture {
                                selectedColor = button.color
                            }
                    }
                }
                
                ColorPicker("", selection: $colorPicker)
                    .labelsHidden()
                    .frame(width: 25, height: 25)
                    .overlay {
                        if selectedColor == colorPicker {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.black)
                                .bold()
                        } else {
                            EmptyView()
                        }
                    }
                    .onChange(of: colorPicker) { oldValue, newValue in
                        selectedColor = newValue
                    }
            }
        }
        .padding()
    }
        
}

enum ColorButton: CaseIterable {
    case white, pink, yellow01, yellow02, green01, green02, blue01, blue02
    
    var color: Color {
        switch self {
        case .white:
            Color(hex: "FFFFFF")
        case .pink:
            Color(hex: "EB7777")
        case .yellow01:
            Color(hex: "FFC97F")
        case .yellow02:
            Color(hex: "FEC600")
        case .green01:
            Color(hex: "C9E7DB")
        case .green02:
            Color(hex: "73BFBA")
        case .blue01:
            Color(hex: "3CA5D9")
        case .blue02:
            Color(hex: "2364AA")
        }
    }
}


#Preview {
    BackgroundColorSheet()
}
