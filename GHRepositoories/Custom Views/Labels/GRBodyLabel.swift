//
//  GRBodyLabel.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 19/09/2021.
//


import UIKit

class GRBodyLabel: UILabel {

    //MARK:- properties

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    //MARK:- custom actions

    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .subheadline)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.85
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
