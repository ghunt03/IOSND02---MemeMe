//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Gareth Hunt on 7/02/2016.
//  Copyright © 2016 ghunt03. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UICollectionViewController {

  
    @IBOutlet var collView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collView.reloadData()
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    
    // MARK: Collection View Data Source
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemeCollectionCell", forIndexPath: indexPath) as! SentMemeCollectionCell
        let meme = memes[indexPath.row]
        
        // Set the image
        cell.memeImageView?.image = meme.memedImage
        cell.contentView.frame = cell.bounds;
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }

}