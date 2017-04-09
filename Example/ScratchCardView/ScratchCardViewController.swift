//
//  ViewController.swift
//  ScratchCardView
//
//  Created by pgorzelany on 04/09/2017.
//  Copyright (c) 2017 pgorzelany. All rights reserved.
//

import UIKit
import ScratchCardView

class ScratchCardViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var scratchCardView: ScratchCardView!
    @IBOutlet var coverView: UIView!
    
    // MARK: Properties
    
    var currentImage = #imageLiteral(resourceName: "tailor-image")
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScratchCardView()
    }
    
    // MARK: Configuration
    
    private func configureScratchCardView() {
        scratchCardView.delegate = self
        scratchCardView.scratchWidth = 150
    }
    
    // MARK: Actions
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        currentImage = #imageLiteral(resourceName: "tailor-image-2")
        scratchCardView.reloadView()
    }
}

extension ScratchCardViewController: ScratchCardViewDelegate {
    
    func coverView(for scratchCardView: ScratchCardView) -> UIView {
        return coverView
    }
    
    func contentView(for scratchCardView: ScratchCardView) -> UIView {
        let imageView = UIImageView(image: currentImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

