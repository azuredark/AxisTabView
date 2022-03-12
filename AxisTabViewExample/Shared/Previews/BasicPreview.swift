//
//  BasicPreview.swift
//  
//
//  Created by jasu on 2022/03/04.
//  Copyright (c) 2022 jasu All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import SwiftUI
import AxisTabView

struct BasicPreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init(selectWidth: 140))
    @State private var color: Color = .blue
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                ATBasicStyle(state, color: color)
            } content: {
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 0, systemName: "01.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 1, systemName: "02.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 2, systemName: "03.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 3, systemName: "04.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 4, systemName: "05.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, color: $color, tag: 5, systemName: "06.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .navigationTitle("Screen \(selection + 1)")
    }
}

fileprivate
struct ControllView: View {

    @Binding var selection: Int
    @Binding var constant: ATConstant
    @Binding var color: Color
    
    let tag: Int
    let systemName: String
    let safeAreaTop: CGFloat
    
    private var backgroundColor: Color {
        let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
        guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
        return colors[selection].opacity(0.2)
    }
    
    private var content: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("● AxisMode").opacity(0.5)
                Picker(selection: $constant.axisMode) {
                    Text("Top")
                        .tag(ATAxisMode.top)
                    Text("Bottom")
                        .tag(ATAxisMode.bottom)
                } label: {
                    Text("AxisMode")
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding(.leading)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("● Screen Transition").opacity(0.5)
                Picker(selection: $constant.screen.transitionMode) {
                    Text("Slide")
                        .tag(ATTransitionMode.slide(50))
                    Text("Opacity")
                        .tag(ATTransitionMode.opacity)
                    Text("Scale")
                        .tag(ATTransitionMode.scale(0.90))
                    Text("None")
                        .tag(ATTransitionMode.none)
                } label: {
                    EmptyView()
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding(.leading)
                Toggle(isOn: $constant.screen.activeSafeArea) {
                    Text("SafeArea Toggle")
                }
                .padding(.horizontal)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("● Tab Normal Size").opacity(0.5)
                HStack {
                    Text("W").frame(width: 24, alignment: .leading)
                    Spacer()
                    Slider(value: $constant.tab.normalSize.width, in: 50...100)
                    Spacer()
                    Text("\(constant.tab.normalSize.width, specifier: "%.2f")")
                }
                .padding(.leading)
                HStack {
                    Text("H").frame(width: 24, alignment: .leading)
                    Spacer()
                    Slider(value: $constant.tab.normalSize.height, in: 50...100)
                    Spacer()
                    Text("\(constant.tab.normalSize.height, specifier: "%.2f")")
                }
                .padding(.leading)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("● Tab Select Width").opacity(0.5)
                HStack {
                    Text("W").frame(width: 24, alignment: .leading)
                    Spacer()
                    Slider(value: $constant.tab.selectWidth, in: -1...200)
                    Spacer()
                    Text("\(constant.tab.selectWidth, specifier: "%.2f")")
                    
                }
                .padding(.leading)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("● Tab Spacing").opacity(0.5)
                Picker(selection: $constant.tab.spacingMode) {
                    Text("Center")
                        .tag(ATSpacingMode.center)
                    Text("Average")
                        .tag(ATSpacingMode.average)
                } label: {
                    EmptyView()
                }
                .pickerStyle(.segmented)
                .padding(.leading)
                HStack {
                    Text("Spacing")
                    Spacer()
                    Slider(value: $constant.tab.spacing, in: 0...30)
                    Spacer()
                    Text("\(constant.tab.spacing, specifier: "%.2f")")
                }
                .disabled(constant.tab.spacingMode == .average)
                .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                .padding(.leading)
                
                HStack {
                    Text("Color")
                    Spacer()
                    ColorPicker("", selection: $color)
                }
                .padding(.leading)
                .labelsHidden()
            }
        }
    }
    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
            if constant.axisMode == .bottom {
                ScrollView {
                    content
                        .padding()
                        .padding(.top, getTopPadding())
                }
            }else {
                ScrollView {
                    content
                        .padding()
                        .padding(.top, getTopPadding())
                }
            }
        }
        .tabItem(tag: tag, normal: {
            TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
        }, select: {
            TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
        })
    }
    
    private func getTopPadding() -> CGFloat {
        guard !constant.screen.activeSafeArea else { return 0 }
        return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
    }
}

fileprivate
struct TabButton: View {
    
    @Binding var constant: ATConstant
    @Binding var selection: Int
    
    let tag: Int
    let isSelection: Bool
    let systemName: String

    @State private var w: CGFloat = 0
    
    var content: some View {
        HStack(spacing: 0) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .font(.system(size: 24))
                .padding(10)
            if isSelection {
                Text(systemName)
                    .lineLimit(1)
            }
        }
        .frame(width: w, height: constant.tab.normalSize.height * 0.85, alignment: .leading)
        .foregroundColor(isSelection ? Color.white : Color.black)
        .background(isSelection ? Color.accentColor : Color.clear)
        .clipShape(Capsule())
        .onAppear {
            w = constant.tab.normalSize.width
            if isSelection {
                withAnimation(.easeInOut(duration: 0.26)) {
                    w = constant.tab.selectWidth < 0 ? constant.tab.normalSize.width : constant.tab.selectWidth + 5
                }
                withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                    w = constant.tab.selectWidth < 0 ? constant.tab.normalSize.width : constant.tab.selectWidth
                }
            }else {
                w = constant.tab.normalSize.width
            }
        }
    }
    var body: some View {
        if constant.axisMode == .top {
            content
        }else {
            content
        }
    }
}

struct BasicPreview_Previews: PreviewProvider {
    static var previews: some View {
        BasicPreview()
    }
}
