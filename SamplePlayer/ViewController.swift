//
//  ViewController.swift
//  SamplePlayer
//
//  Created by Nikhil Challagulla on 1/23/22.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var timer = Timer()
    // MARK: - Private
    private var playerLayer: AVPlayerLayer!
    private var player: AVPlayer!
    private var playerItem: AVPlayerItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8") else { return }
        // Setup Player Layer
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player = AVPlayer(url: url)
        player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)

        playerLayer.player = player
        player.play()

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            print(CMTimeGetSeconds(self.player.currentTime()))
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "rate" {
            if player.rate > 0 {
                print("video started")
            } else {
                print("video Stopped ")
            }
        }
    }

    
}
