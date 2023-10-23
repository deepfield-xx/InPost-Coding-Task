//
//  PackListGroupView.swift
//  InPost Interview Coding Task
//

import UIKit

final class PackListGroupView: UIView {
    private let leftSeparatorView = UIView()
    private let rightSeparatorView = UIView()
    private let groupNameLabel = UILabel()
    private let stackView = UIStackView()
    
    private var isFirst: Bool
    
    init(frame: CGRect = .zero, isFirst: Bool = false) {
        self.isFirst = isFirst
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        isFirst = false
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        [self, leftSeparatorView, rightSeparatorView, groupNameLabel, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        backgroundColor = .groupViewGray
        leftSeparatorView.backgroundColor = .separatorGray
        rightSeparatorView.backgroundColor = .separatorGray
        groupNameLabel.textColor = .groupTitleGray
        groupNameLabel.font = .montserratSemiBold(13)
        
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        addSubview(stackView)
        stackView.addArrangedSubview(leftSeparatorView)
        stackView.addArrangedSubview(groupNameLabel)
        stackView.addArrangedSubview(rightSeparatorView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: isFirst ? 16 : 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            leftSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            rightSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            leftSeparatorView.widthAnchor.constraint(equalTo: rightSeparatorView.widthAnchor, multiplier: 1)
        ])
    }
    
    func setup(groupName: String?) {
        groupNameLabel.text = groupName
    }
}
