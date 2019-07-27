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
            (coverView: customCoverView, contentView: UIImageView(image: #imageLiteral(resourceName: "tailor-image-3")))
        ]
        
        scratchCards.forEach { (scratchCard) in
            if let coverImageView = scratchCard.contentView as? UIImageView {
                coverImageView.contentMode = .scaleAspectFill
            }
        }
    }
    
    private func configureScratchCardView() {
        scratchCardView.delegate = self
        scratchCardView.scratchWidth = 50
    }
    
    // MARK: Actions
    
    @IBAction func nextButtonTouched(_ sender: UIBarButtonItem) {
        currentIndex = (currentIndex + 1) % (scratchCards.count)
        scratchCardView.reloadView()
    }
}

extension ScratchCardViewController: ScratchCardViewDelegate, UITableViewDelegate {
    
    func coverView(for scratchCardView: ScratchCardView) -> UIView {
        return scratchCards[currentIndex].coverView
    }
    
    func contentView(for scratchCardView: ScratchCardView) -> UIView {
        return scratchCards[currentIndex].contentView
    }
    
    func scratchCardView(_ view: ScratchCardView, didScratchTo point: CGPoint) {
        print("Did scratch to \(point)")
    }
    
    func scratchCardView(_ view: ScratchCardView, didStartScratchingAt point: CGPoint) {
        print("Did start scratching at \(point)")
    }
    
    func scratchCardViewDidEndScratching(_ view: ScratchCardView) {
        print("Did end scratching")
        print("Scratch Percent: \(view.scratchPercent)")
    }
}

