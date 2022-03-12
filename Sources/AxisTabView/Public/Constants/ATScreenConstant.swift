//
//  ATScreenConstant.swift
//  AxisTabView
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

/// The mode of the transition animation in the content view.
public enum ATTransitionMode: Hashable {
    case slide(CGFloat)
    case scale(CGFloat)
    case opacity
    case none
}

/// A constant for the content view.
public struct ATScreenConstant: Equatable {
    
    /// Activate the SafeArea area.
    public var activeSafeArea: Bool
    
    /// The mode of the transition animation in the content view.
    public var transitionMode: ATTransitionMode
    
    /// An animation of the content viewer.
    public var animation: Animation?
    
    /// Initializes `ATScreenConstant`
    /// - Parameters:
    ///   - activeSafeArea: Activate the SafeArea area.
    ///   - transitionMode: The mode of the transition animation in the content view.
    ///   - animation: An animation of the content viewer.
    public init(activeSafeArea: Bool = true,
                transitionMode: ATTransitionMode = .opacity,
                animation: Animation? = .easeInOut(duration: 0.28)) {
        self.activeSafeArea = activeSafeArea
        self.transitionMode = transitionMode
        self.animation = animation
    }
}
