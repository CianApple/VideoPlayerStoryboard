//
//  ViewController.swift
//  VideoPlayerStoryboard
//
//  Created by Jai Dhorajia on 2022-08-08.
//

import AVFoundation
import Down
import Alamofire
import UIKit
import WebKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Variables
    var videoPlayer: AVPlayer!
    var currentVideoIndex: Int = 0 {
        didSet {
            togglePreviousNextButtonState()
            updateDescriptionDetailsWith(description: videoArray[currentVideoIndex].description)
            updateVideoFrom(hlsURL: videoArray[currentVideoIndex].hlsURL)
        }
    }
    var videoArray: [Video] = []
    
    // MARK: - View Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchVideos()
    }
    
    // MARK: - Helper Methods
    
    func fetchVideos() {
        let request = AF.request("http://localhost:4000/videos")
        request.responseDecodable(of: [Video].self) { (response) in
            guard let videos = response.value else { return }
            self.videoArray.removeAll()
            self.videoArray = videos
            self.currentVideoIndex = 0
        }
    }
    
    func togglePreviousNextButtonState() {
        previousButton.isEnabled = (currentVideoIndex != 0)
        nextButton.isEnabled = (currentVideoIndex != (videoArray.count - 1))
    }
    
    func updateVideoFrom(hlsURL: URL?) {
        guard let hlsURL = hlsURL else {
            return
        }
        videoPlayer = AVPlayer(url: hlsURL)
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = self.videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(videoPlayDidEnd(_:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: videoPlayer.currentItem)
    }
    
    @objc func videoPlayDidEnd(_ notification: NSNotification) {
        videoPlayer.seek(to: .zero)
        videoPlayer.pause()
        animateShowHideButtonsView(show: true)
    }
    
    func updateDescriptionDetailsWith(description: String?) {
        let down = Down(markdownString: description ?? "")
        descriptionTextView.attributedText = try? down.toAttributedString()
        
        let attributedText = NSMutableAttributedString(attributedString: descriptionTextView.attributedText!)
        let text = descriptionTextView.text! as NSString
        let boldRange = text.range(of: descriptionTextView.text!)
        let boldFont = UIFont(name: "Noteworthy-bold", size: 18.0) as Any
        attributedText.addAttribute(NSAttributedString.Key.font, value: boldFont, range: boldRange)
        descriptionTextView.attributedText = attributedText
    }
    
    func animateShowHideButtonsView(show: Bool = false) {
        UIView.animate(withDuration: 1.0) {
            self.buttonsView.alpha = CGFloat(show ? 1.0 : 0.0)
        }
    }
    
    func resetPlayer() {
        videoPlayer.pause()
        playButton.isSelected = false
        animateShowHideButtonsView(show: true)
    }
    
    // MARK: - IBActions
    
    @IBAction func playButton_pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            videoPlayer.play()
            animateShowHideButtonsView()
        } else {
            videoPlayer.pause()
        }
    }
    
    @IBAction func previousButton_pressed(_ sender: UIButton) {
        resetPlayer()
        currentVideoIndex -= 1
    }
    
    @IBAction func nextButton_pressed(_ sender: UIButton) {
        resetPlayer()
        currentVideoIndex += 1
    }
    
    @IBAction func tappedOnVideoView(_ sender: Any) {
        animateShowHideButtonsView(show: true)
        resetPlayer()
    }
}

