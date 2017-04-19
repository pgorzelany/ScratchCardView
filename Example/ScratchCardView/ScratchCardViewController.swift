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
    
    typealias ScratchCard = (coverView: UIView, contentView: UIView)
    
    // MARK: Outlets
    
    @IBOutlet weak var scratchCardView: ScratchCardView!
    @IBOutlet var basicCoverView: UIView!
    @IBOutlet var blurCoverView: UIView!
    @IBOutlet var customCoverView: UIView!
    
    // MARK: Properties
    
    var currentImage = #imageLiteral(resourceName: "tailor-image")
    var currentIndex = 0
    var scratchCards = [ScratchCard]()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScratchCards()
        configureScratchCardView()
    }
    
    // MARK: Configuration
    
    private func configureScratchCards() {
        scratchCards = [
            (coverView: basicCoverView, contentView: UIImageView(image: #imageLiteral(resourceName: "tailor-image"))),
            (coverView: blurCoverView, contentView: UIImageView(image: #imageLiteral(resourceName: "tailor-image-2"))),
            (coverView: customCoverView, contentView: UIImageView(image: #imageLiteral(resourceName: "tailor-image")))
        ]
    }
    
    private func configureScratchCardView() {
        scratchCardView.delegate = self
        scratchCardView.scratchWidth = 150
    }
    
    // MARK: Actions
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        currentIndex = (currentIndex + 1) % (scratchCards.count)
        scratchCardView.reloadView()
    }
}

extension ScratchCardViewController: ScratchCardViewDelegate {
    
    func coverView(for scratchCardView: ScratchCardView) -> UIView {
        return scratchCards[currentIndex].coverView
    }
    
    func contentView(for scratchCardView: ScratchCardView) -> UIView {
        return scratchCards[currentIndex].contentView
    }
}

