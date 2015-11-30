//
//  TutorialViewCellCollectionViewCell.swift
//  TutorialView
//
//  Created by JV on 11/4/15.
//  Copyright © 2015 PebbleBee. All rights reserved.
//

import UIKit

public class TutorialViewCell: UICollectionViewCell {
    
    
    
    var cellImage: UIImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        self.cellImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.addSubview(self.cellImage)
        
        self.constrainImageView()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrainImageView() {
        
        var constraints = [NSLayoutConstraint]()
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[image]|", options: [], metrics: nil, views: ["image":self.cellImage])
        
        for c in verticalConstraints {
            constraints.append(c)
        }
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[image]|", options: [], metrics: nil, views: ["image":self.cellImage])

        for c in horizontalConstraints {
            constraints.append(c)
        }
        
        self.addConstraints(constraints)
    
    }
    
    
}
