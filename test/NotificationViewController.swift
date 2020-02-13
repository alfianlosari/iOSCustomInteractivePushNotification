//
//  NotificationViewController.swift
//  test
//
//  Created by Alfian Losari on 10/02/20.
//  Copyright © 2020 alfianlosari. All rights reserved.
//

import UIKit
import AVKit
import UserNotifications
import UserNotificationsUI
import XCDYouTubeKit
import Cosmos

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var reviewStackView: UIStackView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    @IBOutlet weak var submitLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var playerController: AVPlayerViewController!
    let standardHeight: CGFloat = 432
    let reviewHeight: CGFloat = 658
    
    var isSubscribed = false {
        didSet {
            self.subscribeButton.tintColor = self.isSubscribed ? UIColor.systemGray : UIColor.systemBlue
            self.subscribeButton.setTitle(self.isSubscribed ? " Added" : " Add", for: .normal)
        }
    }
    
    var isFavorited = false {
        didSet {
            self.favoriteButton.tintColor = self.isFavorited ? UIColor.systemGray : UIColor.systemBlue
            self.favoriteButton.setTitle(self.isFavorited ? " Favorited" : " Favorite", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeButton.setImage(UIImage(systemName: "calendar"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        reviewButton.setImage(UIImage(systemName: "pencil"), for: .normal)

        reviewStackView.isHidden = true
        submitLabel.isHidden = true
    }
    
    func didReceive(_ notification: UNNotification) {
        playerController = AVPlayerViewController()
        preferredContentSize.height = standardHeight
        videoTitleLabel.text = notification.request.content.body
        videoDescriptionLabel.text = notification.request.content.userInfo["description"] as? String ?? ""
        
        guard let videoId = notification.request.content.userInfo["videoId"] as? String else {
            self.preferredContentSize.height = 100
            return
        }
        
        XCDYouTubeClient.default().getVideoWithIdentifier(videoId) { [weak self] (video, error) in
            guard let self = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let video = video else {
                return
            }
            
            let streamURLS = video.streamURLs
            if let url = streamURLS[XCDYouTubeVideoQuality.medium360] ?? streamURLS[XCDYouTubeVideoQuality.small240] ?? streamURLS[XCDYouTubeVideoQuality.HD720] ?? streamURLS[18]   {
                self.setupPlayer(with: url)
            }
        }
    }
    
    private func setupPlayer(with url: URL) {
        guard let playerController = self.playerController else {
            return
        }
        
        let player = AVPlayer(url: url)
        playerController.player = player
        playerController.view.frame = self.playerView.bounds
        playerView.addSubview(playerController.view)
        addChild(playerController)
        playerController.didMove(toParent: self)
        player.play()
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.reviewStackView.isHidden = true
            self.submitLabel.isHidden = false
            self.preferredContentSize.height = self.standardHeight
        }
    }
    
    @IBAction func reviewTapped() {
        UIView.animate(withDuration: 0.3) {
            self.preferredContentSize.height = self.reviewHeight
            self.reviewStackView.isHidden = false
            self.reviewButton.isHidden = true
        }
    }
    
    @IBAction func subscribeTapped(_ sender: Any) {
        self.isSubscribed.toggle()
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        self.isFavorited.toggle()
    }
}
