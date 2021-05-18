//
//  UIApplicationExtensions.swift
//  Common
//
//  Created by Laurent Droguet on 17/05/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import UIKit

extension UIApplication {
    public static var screenHasNotch: Bool {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom != 0
    }
}
