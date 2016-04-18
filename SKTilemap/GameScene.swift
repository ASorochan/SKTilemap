//
//  GameScene.swift
//  SKTilemap
//
//  Created by Thomas Linthwaite on 07/04/2016.
//  Copyright (c) 2016 Tom Linthwaite. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
// MARK: Properties
    var tilemap: SKTilemap?
    let worldNode: SKNode
    var sceneCamera: Camera!
    
// MARK: Initialization
    override init(size: CGSize) {
        
        worldNode = SKNode()
        
        super.init(size: size)
        
        addChild(worldNode)
    }
    
    var tilemapBounds = CGRectZero
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        /* Setup a basic Camera object to allow for panning/zooming. */
        sceneCamera = Camera(scene: self, view: view, worldNode: worldNode)
        addChild(sceneCamera)
        camera = sceneCamera
        
        /* Load Tilemap from .tmx file and add it to the scene through the worldNode. */
        if let tilemap = SKTilemap.loadTMX(name: "tilemap_isometric") {
            
            /* Print tilemap information to console, useful for debugging. */
            //tilemap.printDebugDescription()
            worldNode.addChild(tilemap)
            self.tilemap = tilemap
        }
        
        tilemapBounds = CGRect(x: -(view.bounds.width / 2) + 64,
                               y: -(view.bounds.height / 2) + 64,
                               width: view.bounds.width - 128,
                               height: view.bounds.height - 128)
        sceneCamera.bounds = tilemapBounds
        
        //bounds.origin = convertPoint(bounds.origin, toNode: sceneCamera)
        let boundsShape = SKShapeNode(rect: tilemapBounds)
        boundsShape.antialiased = false
        boundsShape.lineWidth = 1
        boundsShape.strokeColor = SKColor.blueColor()
        boundsShape.zPosition = 1000
        sceneCamera.addChild(boundsShape)
        
        /* Create a tilemap Programatically */
        //        tilemap = SKTilemap(size: CGSize(width: 32, height: 32), tileSize: CGSize(width: 32, height: 32), orientation: .Orthogonal)
        //        worldNode.addChild(tilemap!)
        //
        //        let layer = SKTilemapLayer(tilemap: tilemap!, name: "ground layer")
        //        tilemap!.add(tileLayer: layer)
        //
        //        let tileset = SKTilemapTileset(name: "tileset", firstGID: 1, tileSize: tilemap!.tileSize)
        //        tileset.margin = 1
        //        tileset.spacing = 1
        //        tileset.addTileData(spriteSheet: "tmw_desert_spacing.png")
        ////        tileset.addTileData(id: 1, imageNamed: "grass.png")
        ////        tileset.addTileData(id: 2, imageNamed: "water")
        ////        tileset.addTileData(id: 3, imageNamed: "sand")
        ////        tileset.addTileData(id: 4, imageNamed: "dirt.png")
        //        tilemap!.add(tileset: tileset)
        //
        //        for y in 0..<Int(tilemap!.size.height) {
        //            for x in 0..<Int(tilemap!.size.width) {
        //                layer.setTileAt(x: x, y: y, id: 1)
        //            }
        //        }
    }
    
    // MARK: Input
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            if let layer = tilemap?.getLayer(name: "ground layer") {
                
                //                if let tile = layer.tileAtTouchPosition(touch) {
                //
                //                    tile.sprite.alpha = 0.5
                //                }
                
                if let coord = layer.coordAtTouchPosition(touch) {
                    print(coord)
                }
            }
        }
    }
    
    var previousTilesInView: [CGPoint] = []
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            sceneCamera.panCamera(touch)
            tilemap?.clipTilesOutOfBounds(CGRect(x: 64, y: 64, width: view!.bounds.width - 128, height: view!.bounds.height - 128))
        }

    }
}