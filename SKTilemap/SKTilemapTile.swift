//
//  SKTilemapTile.swift
//  SKTilemap
//
//  Created by Thomas Linthwaite on 14/04/2016.
//  Copyright © 2016 Tom Linthwaite. All rights reserved.
//

import SpriteKit

// MARK: SKTile
class SKTilemapTile : SKNode {
    
// MARK: Properties
    
    /** The tile data this tile represents. */
    let tileData: SKTilemapTileData
    
    /** The sprite of the tile. */
    let sprite: SKSpriteNode
    
// MARK: Initialization
    
    /* Initialize an SKTile using SKTileData. */
    init(tileData: SKTilemapTileData) {
        
        self.tileData = tileData
        sprite = SKSpriteNode(texture: tileData.texture)
        
        super.init()
        
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Animation
    
    /** Will start the animation from this tiles tileData if it has one. */
    func playAnimation(tilemap: SKTilemap, loopForever: Bool = true) {
        
        if let animation = tileData.getAnimation(tilemap) {
            
            if loopForever {
                sprite.runAction(SKAction.repeatActionForever(animation), withKey: "tile animation")
            } else {
                sprite.runAction(animation, withKey: "tile animation")
            }
        }
    }
    
    /** Stops the tile animating. */
    func stopAnimation() {
        sprite.removeActionForKey("tile animation")
    }
}