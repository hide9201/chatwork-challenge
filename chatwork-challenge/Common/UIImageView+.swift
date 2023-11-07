//
//  UIImageView+.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/07.
//

import Foundation
import UIKit
import Nuke

enum ProcessorsOption {
    case none
    case round(radius: CGFloat)
    case circle
}

extension UIImageView {

    func load(_ url: URL?, processorOption: ProcessorsOption = .none, placeholder: UIImage? = nil, contentMode: UIImageView.ContentMode = .scaleAspectFit) {
        guard let url = url else { return }
        let resizeProcessor = ImageProcessors.Resize(size: self.bounds.size)
        let processors: [ImageProcessing]
        switch processorOption {
        case .none:
            processors = [resizeProcessor]
        case .round(let radius):
            processors = [resizeProcessor, ImageProcessors.RoundedCorners(radius: radius)]
        case .circle:
            processors = [resizeProcessor, ImageProcessors.Circle()]
        }
        let request = ImageRequest(url: url, processors: processors)

        let contentModes = ImageLoadingOptions.ContentModes(success: contentMode, failure: contentMode, placeholder: contentMode)
        let options: ImageLoadingOptions = {
            if let placeholder = placeholder {
                return ImageLoadingOptions(placeholder: placeholder, contentModes: contentModes)
            } else {
                return ImageLoadingOptions(contentModes: contentModes)
            }
        }()
        
        Nuke.loadImage(with: request, options: options, into: self)
    }
}
