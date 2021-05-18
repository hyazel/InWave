//
//  UIImageExtensions.swift
//  Common
//
//  Created by Laurent Droguet on 18/05/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import UIKit

extension UIImage {
    /// Average color of the image, nil if it cannot be found
    public var averageColor: UIColor {
        guard let inputImage = CIImage(image: self) else { return .black }
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector])
        else { return .black }
        
        guard let outputImage = filter.outputImage else { return .black }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255,
                       green: CGFloat(bitmap[1]) / 255,
                       blue: CGFloat(bitmap[2]) / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
}
