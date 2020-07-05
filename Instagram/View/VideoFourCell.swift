//
//  VideoFourCell.swift
//  Instagram
//
//  Created by MTQ on 6/30/20.
//  Copyright © 2020 seesaa. All rights reserved.
//

import UIKit

class VideoFourCell: UICollectionViewCell {
    
    var playerContainerView: UIView!
    
    // Reference for the player view.
    private var playerView: PlayerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpPlayerContainerView()
        setUpPlayerView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playerView = nil
    }
    
    @objc func playerDidFinishPlaying() {
        playerView.player?.seek(to: .zero)
    }

    private func setUpPlayerContainerView() {
        playerContainerView = UIView()
        playerContainerView.backgroundColor = .black
        addSubview(playerContainerView)
        playerContainerView.translatesAutoresizingMaskIntoConstraints = false
        playerContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playerContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        playerContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        playerContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setUpPlayerView() {
        playerView = PlayerView()
        playerContainerView.addSubview(playerView)
            
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerContainerView.widthAnchor, multiplier: 16/9).isActive = true
        playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor).isActive = true
    }
    
    func playVideo(url: URL) {
        playerView.play(with: url)
    }
}
