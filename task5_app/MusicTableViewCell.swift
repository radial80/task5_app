//
//  MusicTableViewCell.swift
//  task5_app
//
//  Created by Recep Uyduran on 4.09.2023.
//

import UIKit
import MediaPlayer

class MusicTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var playlistImageView: UIImageView!

    func setCell(
        title: String,
        count: Int? = nil,
        artwork: MPMediaItemArtwork? = nil
    ) {
        titleLabel.text = title
        if let count = count {
            countLabel.text = "\(count) songs"
        }
        if let playlistImage = artwork?.image(at: CGSize(width: 50, height: 50)) {
            playlistImageView.image = playlistImage
        }
    }
}
