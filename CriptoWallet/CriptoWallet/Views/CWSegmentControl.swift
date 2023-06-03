//
//  CWSegmentControl.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 06.05.2022.
//

import UIKit

protocol CWSegmentControlDelegate: AnyObject {
    func segmentControlDidTabted(didSelectIndex: Int)
}

class CWSegmentControl: UIStackView {
    weak var delegate: CWSegmentControlDelegate?
    private var selectedButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = 0
    }
    
    private(set) var sectionsCount: Int = 0
    
    func addSegment(name: String) {
        let button = SegmentControlButton()
        button.tag = sectionsCount
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: #selector(segmentDidTapped), for: .touchUpInside)
        addArrangedSubview(button)
        sectionsCount += 1
    }
    
    @objc func segmentDidTapped(sender: UIButton) {
        delegate?.segmentControlDidTabted(didSelectIndex: sender.tag)
        selectedButton?.isSelected = false
        sender.isSelected = !sender.isSelected
        selectedButton = sender
        
    }
    
    func removeAllSegments() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    // задний фон кнопки()
}

class SegmentControlButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.blue, for: .normal)
        setTitleColor(.white, for: .selected)
        setTitleColor(.gray, for: .disabled)
    }
    
    required init?(coder: NSCoder) { nil }
    
}
