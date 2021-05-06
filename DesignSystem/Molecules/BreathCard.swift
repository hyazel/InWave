//
//  BreathCard.swift
//  InWave
//
//  Created by Laurent Droguet on 11/01/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct BreathCard: View {
    private let imageName: String
    private let title: String
    private let subtitle: String
    private let duration: String
    private let imageSize: CGSize
    
    public init(imageName: String, title: String, subtitle: String, duration: String, imageSize: CGSize = CGSize(width: 92, height: 92)) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
        self.imageSize = imageSize
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 12) {
                Image(imageName)
                    .resizable()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .clipShape(Circle())
                    .shadow(color: Color(UIImage(named: imageName)!.averageColor).opacity(1), radius: 1.0, x: 0, y: 3)
                
                VStack(spacing: 20) {
                    VStack(spacing: 6) {
                        Text(title)
                            .font(Font.detail())
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Text(subtitle)
                            .font(Font.title3())
                            .foregroundColor(.black)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .frame(height: 35)
                    }
                    Text(duration)
                        .font(Font.detail())
                        .foregroundColor(Color.Palette.shell)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding([.trailing, .leading, .bottom], 12)
            .padding(.top, 24)
            .background(Color.white)
            .cornerRadius(24)
        }
    }
}

struct BreathCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary().edgesIgnoringSafeArea(.all)
            HStack {
                BreathCard(imageName: "squared",
                           title: "Respiration Relaxante",
                           subtitle: "Marche Afghane, to reach the calm.",
                           duration: "30 MIN",
                           imageSize: CGSize(width: 92,
                                             height: 92))
                    .frame(width: 182, height: 234)
                
                BreathCard(imageName: "buteyko",
                           title: "Marche Afghane",
                           subtitle: "Marche Afghane",
                           duration: "30 MIN",
                           imageSize: CGSize(width: 92,
                                             height: 92))
                    .frame(width: 182, height: 234)
            }
        }
    }
}

extension UIImage {
    /// Average color of the image, nil if it cannot be found
    var averageColor: UIColor {
        guard let inputImage = CIImage(image: self) else { return .black }
                let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return .black }
        guard let outputImage = filter.outputImage else { return .black }

                var bitmap = [UInt8](repeating: 0, count: 4)
                let context = CIContext(options: [.workingColorSpace: kCFNull])
                context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

                return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
