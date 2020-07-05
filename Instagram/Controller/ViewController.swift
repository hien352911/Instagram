//
//  ViewController.swift
//  Instagram
//
//  Created by MTQ on 6/29/20.
//  Copyright © 2020 seesaa. All rights reserved.
//

import UIKit
import SDWebImage
import SwifterSwift

enum InstagramType: String {
    case image
    case moreImage
//    case videoOne
    case videoFour
}

class ViewController: UICollectionViewController {
    
    var datas: [InstagramInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(nibWithCellClass: ImageCell.self)
        collectionView.register(nibWithCellClass: VideoFourCell.self)
        
        let layout = InstagramLayout()
        layout.delegate = self
        
        collectionView.collectionViewLayout = layout
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        if let data = readDataFromLocal() {
            let arr = data["data"] as! [[String: Any]]
            let datas = arr.map { InstagramInfo(dict: $0) }
            self.datas = datas
            self.collectionView.reloadData()
        }
    }
    
    private func readDataFromLocal() -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: "Instagram", ofType: "json") else {
            return nil
        }
        
        do {
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe) else {
                return nil
            }
            
            let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
            
            return dict
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let instagramInfo = datas[indexPath.item]

        switch instagramInfo.type {
        case .moreImage, .image:
            let cell = collectionView.dequeueReusableCell(withClass: ImageCell.self, for: indexPath)
            
            cell.imageView.sd_setImage(with: URL(string: instagramInfo.url))
            cell.isMoreImage = instagramInfo.type == .moreImage
            
            return cell
            
        case .videoFour:
            let cell = collectionView.dequeueReusableCell(withClass: VideoFourCell.self, for: indexPath)
            
            if let path = Bundle.main.path(forResource: instagramInfo.url, ofType:"mp4") {
                cell.playVideo(url: URL(fileURLWithPath: path))
            }
            
            return cell
        }
    }
}

extension ViewController: InstagramLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, mosaicSegmentStyleForItemAtIndexPath indexPath: IndexPath) -> MosaicSegmentStyle {
        let instagramInfo = datas[indexPath.item]
        
        if indexPath.item % 3 == 0 {
            return instagramInfo.mosaicSegmentStyle!
        }
        
        return MosaicSegmentStyle.one
    }
}
