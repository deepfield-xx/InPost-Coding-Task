//
//  PackView.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

final class PackView: UIView {
    
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet private(set) var contentContainer: UIView!
    @IBOutlet private(set) var numberTitleLabel: UILabel!
    @IBOutlet private(set) var numberLabel: UILabel!
    @IBOutlet private(set) var statusTitleLabel: UILabel!
    @IBOutlet private(set) var statusLabel: UILabel!
    @IBOutlet private(set) var senderTitleLabel: UILabel!
    @IBOutlet private(set) var senderLabel: UILabel!
    @IBOutlet private(set) var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setup(pack: Pack) {
        numberLabel.setTextWithLineHeight(text: pack.id, lineHeight: 24)
        statusLabel.setTextWithLineHeight(text: pack.status.rawValue, lineHeight: 24)
        senderLabel.setTextWithLineHeight(text: pack.sender, lineHeight: 24)
        imageView.image = pack.status.image
    }
    
    private func setupView() {
        loadView()
        setupContainerStyle()
        setupTexts()
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed("PackView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupContainerStyle() {
        contentContainer.layer.shadowColor = UIColor.black.cgColor
        contentContainer.layer.shadowRadius = 5
        contentContainer.layer.shadowOffset = .init(width: 0, height: 5)
        contentContainer.layer.shadowOpacity = 0.1
        contentContainer.layer.shouldRasterize = true
        
        numberTitleLabel.textColor = .grayLight
        numberTitleLabel.font = .montserratSemiBold(11)
        numberLabel.textColor = .grayDark
        numberLabel.font = .montserratMedium(15)
        
        statusTitleLabel.textColor = .grayLight
        statusTitleLabel.font = .montserratSemiBold(11)
        statusLabel.textColor = .grayDark
        statusLabel.font = .montserratBold(15)
        
        senderTitleLabel.textColor = .grayLight
        senderTitleLabel.font = .montserratSemiBold(11)
        senderLabel.textColor = .grayDark
        senderLabel.font = .montserratBold(15)
    }
    
    private func setupTexts() {
        numberTitleLabel.setTextWithLineHeight(text: "NR PRZESYŁKI", lineHeight: 16)
        statusTitleLabel.setTextWithLineHeight(text: "STATUS", lineHeight: 16)
        senderTitleLabel.setTextWithLineHeight(text: "NADAWCA", lineHeight: 16)
    }
    
}
