//
//  ViewController.swift
//  PhotoGallaryAccessDemo
//
//  Created by Vipin Joshi on 19/08/19.
//  Copyright © 2019 newput. All rights reserved.
//

import UIKit
import Photos

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grabPhotos()
    }
    
    func grabPhotos() {
        
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.isSynchronous = true
        
        let fatchOptions = PHFetchOptions()
        fatchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fatchOptions) {
         
            if fetchResult.count > 0 {
                
                for i in 0..<fetchResult.count {
                    
                    imageManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFit, options: requestOptions, resultHandler: { image,error in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("No Images in gallary.....")
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let cellImage = cell.viewWithTag(1) as! UIImageView
        cellImage.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3 - 1.0
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

