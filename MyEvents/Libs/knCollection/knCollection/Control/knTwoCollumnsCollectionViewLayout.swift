//
//  HighlightCollectionLayout.swift
//  Opiyn
//
//  Created by Ky Nguyen on 9/16/16.
//  Copyright © 2016 Manas Sharma. All rights reserved.
//

import UIKit

struct knTwoColumnCollectionViewSetting {
    static let cellPadding : CGFloat = 6
    static let columnWidth = UIScreen.main.bounds.width / CGFloat(2) - cellPadding * 2
}

final class knTwoCollumnsCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var photoHeight: CGFloat = 0.0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! knTwoCollumnsCollectionViewLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let attributes = object as? knTwoCollumnsCollectionViewLayoutAttributes else { return false }
        if attributes.photoHeight == photoHeight {
            return super.isEqual(object)
        }
        return false
    }
}

protocol knTwoColumnsCollectionViewLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat
}


final class knTwoCollumnsCollectionViewLayout: UICollectionViewLayout {
    var delegate : knTwoColumnsCollectionViewLayoutDelegate!
    var numberOfColumns = 2
    private var cache = [knTwoCollumnsCollectionViewLayoutAttributes]()
    private var contentHeight : CGFloat = 0
    private var contentWidth : CGFloat {
        let inset = collectionView!.contentInset
        return collectionView!.bounds.width - (inset.left + inset.right)
    }
    
    func clearCache() {
        cache.removeAll()
    }
    
    override func prepare() {
        
        guard cache.isEmpty else { return }
        contentHeight = 0
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let cellHeight = delegate.collectionView(collectionView: collectionView!, heightForCellAtIndexPath: indexPath)
            let height = knTwoColumnCollectionViewSetting.cellPadding * 2 + cellHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: knTwoColumnCollectionViewSetting.cellPadding, dy: knTwoColumnCollectionViewSetting.cellPadding)
            
            let attributes = knTwoCollumnsCollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.photoHeight = cellHeight
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column >= (numberOfColumns - 1) ? 0 : column + 1
        }
    }
    
    override var collectionViewContentSize: CGSize { return CGSize(width: contentWidth, height: contentHeight) }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
