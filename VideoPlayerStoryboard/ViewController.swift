//
//  ViewController.swift
//  VideoPlayerStoryboard
//
//  Created by Jai Dhorajia on 2022-08-08.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Variables
    
    // MARK: - View Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Helper Methods
    
    func setupUI() {
        
    }

    
    // MARK: - IBActions
    
    @IBAction func playButton_pressed(_ sender: Any) {
    }
    
    @IBAction func previousButton_pressed(_ sender: Any) {
    }
    
    @IBAction func nextButton_pressed(_ sender: Any) {
    }
}

