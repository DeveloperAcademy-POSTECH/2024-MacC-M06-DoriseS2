//
//  ChoosingColorOfTagView.swift
//  BiRTH
//
//  Created by Hajin on 11/20/24.
//

import SwiftUI

struct ChoosingColorOfTagView: View {

    @Binding var tagColor: String

    let colors: [String] = ["2364AA", "3DA5D9", "73BFB9", "FEC601", "EA7317", "FFC97F", "EB7777", "EB8291", "F0BBCD", "C9E7DB"]

    let columns: [GridItem] = [
        GridItem(.fixed(50), spacing: nil, alignment: nil),
        GridItem(.fixed(50), spacing: nil, alignment: nil),
        GridItem(.fixed(50), spacing: nil, alignment: nil),
        GridItem(.fixed(50), spacing: nil, alignment: nil),
        GridItem(.fixed(50), spacing: nil, alignment: nil)
    ]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.init(hex: "F0F0F0"))
                .frame(width: 324, height: 103)

            LazyVGrid(columns: columns) {
                ForEach(colors, id: \.self) { color in
                    Button {
                        tagColor = color
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.init(hex: color))
                                .frame(width: 30)
                            if tagColor == color {
                                Circle()
                                    .fill(.black)
                                    .opacity(0.2)
                                    .frame(width: 30)
                                Image(systemName: "checkmark")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
    }
}
