//
//  CircleImage.swift
//  Photravel
//
//  Created by 岡田暁 on 2017-11-26.
//  Copyright © 2017 Aki. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
