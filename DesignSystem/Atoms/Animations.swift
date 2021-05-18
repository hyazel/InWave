//
//  Animations.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 17/05/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public enum Animations {
    public static let spring: Animation = Animation.interpolatingSpring(mass: 1,
                                                                        stiffness: 100,
                                                                        damping: 10,
                                                                        initialVelocity: 10)
}
