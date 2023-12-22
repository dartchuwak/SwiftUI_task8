//
//  ContentView.swift
//  SwiftUI_task8
//
//  Created by Evgenii Mikhailov on 22.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State var maxHeight: CGFloat = 200
    @State var scale = CGSize(width: 1, height: 1)
    @State var anchor: UnitPoint = .bottom
    @State var progress: CGFloat = 0
    @State var height: CGFloat = 100
    @State var lastDrag: CGFloat = 100

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.ultraThinMaterial)

                Rectangle()
                    .fill(.white)
                    .frame(height: height)
            }
            .frame(width: 100, height: maxHeight)
            .cornerRadius(35)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        let translation = value.translation.height

                        height = -translation + lastDrag
                        height = min(maxHeight, max(0, height))


                        if height == maxHeight {
                            anchor = .bottom
                            withAnimation {
                                scale = CGSize(width: 0.95, height: 1.3)
                            }
                        }

                        if height < maxHeight - 10 && height > 10 {
                            withAnimation {
                                anchor = .center
                                scale = CGSize(width: 1, height: 1)
                            }
                        }

                        if height == 0 {
                            withAnimation {
                                anchor = .top
                                scale = CGSize(width: 0.95, height:  1.3)
                            }
                        }
                    })
                    .onEnded({ value in
                        height = height > maxHeight ? maxHeight : height
                        height = height >= 0 ? height : 0
                        lastDrag = height
                        withAnimation {
                            scale = CGSize(width: 1, height: 1)
                        }
                    })
            )
            .scaleEffect(scale, anchor: anchor)

        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.gray)


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


