//
//  ViewController.swift
//  task5_app
//
//  Created by Recep Uyduran on 2.09.2023.
//

import UIKit
import MediaPlayer

enum PageType: String, CaseIterable {
    case sounds = "MY SOUNDS"
    case playlist = "MY PLAYLIST"
    case songs = "MY SONGS"
}

class ViewController: UIViewController {

    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    @IBOutlet weak var choosenMusicLabel: UILabel!
    @IBOutlet weak var mySongLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var selectedType = PageType.sounds {
        didSet {
            tableView.reloadData()
        }
    }
//    var soundArray = MPMediaQuery.songs()
    var playlistArray = MPMediaQuery.playlists()
    let allSegmentTypes = PageType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UINib(
                nibName: "MusicTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "MusicTableViewCell"
        )

        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func segmentedControlTapped(_ sender: Any) {
        let selectedIndex = topSegmentedControl.selectedSegmentIndex
        selectedType = allSegmentTypes[selectedIndex]
        mySongLabel.text = allSegmentTypes[selectedIndex].rawValue
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        switch selectedType {
            case .sounds, .playlist, .songs:
                return 1
//            case .songs:
//                return playlistArray.collections?.count ?? 0
        }
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch selectedType {
            case .sounds:
                return playlistArray.collections?.count ?? 0
            case .playlist:
                return playlistArray.collections?.count ?? 0
            case .songs:
                return playlistArray.collections?.count ?? 0
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "MusicTableViewCell",
            for: indexPath
        ) as? MusicTableViewCell {
            switch selectedType {
                case .sounds:
                    if let collection = playlistArray.collections?[indexPath.row],
                       let playListName = collection.value(forKey: MPMediaPlaylistPropertyName) as? String {
                        cell.setCell(title: playListName)
                    }
                case .playlist:
                    if let collection = playlistArray.collections?[indexPath.row],
                       let playListName = collection.value(forKey: MPMediaPlaylistPropertyName) as? String,
                       let artwork = collection.items.first?.artwork {
                        cell.setCell(
                            title: playListName,
                            count: collection.count,
                            artwork: artwork
                        )
                    }
                case .songs:
                    if let collection = playlistArray.collections?[indexPath.row],
                       let playListName = collection.value(forKey: MPMediaPlaylistPropertyName) as? String {
                        cell.setCell(title: playListName)

                    }
            }
            return cell
        } else {
            return UITableViewCell()
        }

    }
}

