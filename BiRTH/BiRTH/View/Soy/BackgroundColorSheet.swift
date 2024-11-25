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
    @EnvironmentObject var colorManager: ColorManager
    @State var colorPicker: Color = .black
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 15) {
                    LazyHGrid(rows: rows) {
                        ForEach(ColorButton.allCases, id: \.self) { button in
                            Circle()
                                .fill(button.color)
                                .frame(width: 25, height: 25)
                                .overlay {
                                    if colorManager.selectedBackgroundColor == button.color {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.black)
                                            .bold()
                                    } else {
                                        EmptyView()
                                    }
                                }
                                .onTapGesture {
                                    colorManager.selectedBackgroundColor = button.color
                                }
                        }
                    }
                    
                    ColorPicker("", selection: $colorPicker)
                        .labelsHidden()
                        .frame(width: 25, height: 25)
                        .overlay {
                            if colorManager.selectedBackgroundColor == colorPicker {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                                    .bold()
                            } else {
                                EmptyView()
                            }
                        }
                        .onChange(of: colorPicker) { oldValue, newValue in
                            colorManager.selectedBackgroundColor = newValue
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    XmarkButton()
                }
            }
        }
    }
    
}

enum ColorButton: CaseIterable {
    case bgWhite, bgPink, bgYellow01, bgYellow02, bgGreen01, bgGreen02, bgBlue01, bgBlue02
    
    var color: Color {
        switch self {
        case .bgWhite:
            Color(hex: "FFFFFF")
        case .bgPink:
            Color(hex: "EB7777")
        case .bgYellow01:
            Color(hex: "FFC97F")
        case .bgYellow02:
            Color(hex: "FEC600")
        case .bgGreen01:
            Color(hex: "C9E7DB")
        case .bgGreen02:
            Color(hex: "73BFBA")
        case .bgBlue01:
            Color(hex: "3CA5D9")
        case .bgBlue02:
            Color(hex: "2364AA")
        }
    }
}


#Preview {
    //    BackgroundColorSheet(, selectedBackgroundColor: <#Binding<Color>#>)
}
