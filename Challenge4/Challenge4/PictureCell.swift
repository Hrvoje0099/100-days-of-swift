//
//  PictureCell.swift
//  Challenge4
//
//  Created by Hrvoje Vuković on 19/07/2019.
//  Copyright © 2019 Hrvoje Vuković. All rights reserved.
//

import UIKit

class PictureCell: UITableViewCell {

    let pictureView: UIImageView = {
        let pictureView = UIImageView()
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        pictureView.contentMode = .scaleAspectFit
        pictureView.clipsToBounds = true
        return pictureView
    }()
    
    let captionLabel: UILabel = {
        let captionLabel = UILabel()
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.font = UIFont.init(name: "Marker Felt", size: 20)
        return captionLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let pictureDimension: CGFloat = 90
        pictureView.layer.cornerRadius = 2
       
        addSubview(pictureView)
        addSubview(captionLabel)
        
        NSLayoutConstraint.activate([
            pictureView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pictureView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            pictureView.widthAnchor.constraint(equalToConstant: pictureDimension),
            pictureView.heightAnchor.constraint(equalToConstant: pictureDimension),
            
            captionLabel.centerYAnchor.constraint(equalTo: pictureView.centerYAnchor),
            captionLabel.leftAnchor.constraint(equalTo: pictureView.rightAnchor, constant: 15)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemnted")
    }

}
