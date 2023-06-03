//
//  TestModuleViewController.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 06.05.2022.
//

import UIKit

class TestModuleViewController: UIViewController {
    @IBOutlet weak var segmentControl: CWSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.addSegment(name: "first")
        segmentControl.addSegment(name: "second")
        segmentControl.addSegment(name: "third")
        segmentControl.delegate = self
    }
    
}

extension TestModuleViewController: CWSegmentControlDelegate {
    func segmentControlDidTabted(didSelectIndex: Int) {
        
    }
    
}
