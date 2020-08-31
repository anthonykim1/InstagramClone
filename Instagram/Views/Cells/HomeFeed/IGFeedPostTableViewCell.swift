//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Anthony Kim on 8/30/20.
//  Copyright © 2020 Anthony Kim. All rights reserved.
//

import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell" // this is how we are going to register the cell

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // how are we going to show each of the cell?
    
    public func configure() {
        // configure the cell 
    }
}
