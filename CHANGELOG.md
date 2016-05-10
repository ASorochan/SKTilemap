#SKTilemap Change Log

###Latest - 10th May 2016

+ **New Property** - *SKTilemapTile* - `let layer: SKTilemapLayer`
    + A tile now has a reference to the layer it belongs to. 
+ **New Property** - *SKTilemapCamera* - `private var longPressGestureRecognizer: UILongPressGestureRecognizer!`
+ **New Property** - *SKTilemapCamera* - `private var previousLocation: CGPoint!`
+ The camera no longer requires you to update the position outside of its own class. (For example in the scene touchesMoved method). Instead a UILongPressGestureRecognizer is created and added to the view on initialization. This change keeps the code cleaner and lets the class handle itself.
+ **New Function** - *SKTilemapCamera* - `func centerOnPosition(scenePosition: CGPoint, easingDuration: NSTimeInterval = 0)`
+ **New Function** - *SKTilemapCamera* - `func centerOnNode(node: SKNode?, easingDuration: NSTimeInterval = 0)`
    + Two new functions for the camera useful for following/focusing on nodes in the scene. Moves the camera so it centers on a certain position within the scene. Easing can be applied by setting a timing value. Otherwise the camera position is updated instantly.

**26th April 2016**

+ **New Class** - *SKTilemapCamera* - `class SKTilemapCamera : SKCameraNode`
    + After a lot of deliberating I've decided to bring the camera class in to the project. It's still not required by SKTilemap and is very much just an additional extra.
+ **New Extension** - *SKTilemapCameraExtension* - `extension SKTilemap : SKTilemapCameraDelegate`
    + Because I didn't want the SKTilemap class itself to know about the camera I decided to create an extension that will respond to camera events. This gives the tilemap a chance to react when the camera moves/zooms or changes its bounds. As I said before you can totally remove this file and the camera and the tilemap will still work as expected.
+ **Misc.** - *Example Code Update*
    + I've re-written the GameScene class to show how to use most of the features within SKTilemap as well as setup the new camera.

**24th April 2016**

+ **New Property** - *SKTilemap* - `var minTileClippingScale: CGFloat`
    + When tile clipping is enabled this property will disable it when the scale passed in goes below this threshold. This is important because the tile clipping can cause serious slow down when a lot of tiles are drawn on screen. Experiment with this value to see what's best for your map. This is only needed if you plan on scaling the tilemap. 
+ **Removed Property** - *SKTilemapObject* - `let position: CGPoint`
+ **New Function** - *SKTilemapObject* - `func positionOnLayer(layer: SKTilemapLayer) -> CGPoint`
    + Position of an object didn't make sense. I tried a few ways to get it working nicely and as expected every time but the truth of the matter is, with the difference in y axis, anchor points and offsets of all of the tile layers/object layers and tiles a set position just didn't feel right and would require to much information from the rest of the map which I didn't want an Object to know about. 
        I've settled for an alternative of getting a position of an object based on a layer already added to the tilemap. This makes it easier to get the position you want at a particular place on the map and solves all of the issues I mentioned above.
+ **New Property** - *SKTilemapObjectGroup* - `let offset: CGPoint`
    + Tiled lets you offset your object layer, so now SKTilemap does to!
+ **Renamed Function** - *SKTilemapObjectGroup* - `func allObjects() -> [SKTilemapObject]` to `func getObjects() -> [SKTilemapObject]`
    + Not sure why I called it allObjects yesterday... Didn't fit with the naming convention for framework.

**23rd April 2016**

+ Created change log...
+ **New Function** - *SKTilemapObjectGroup* - `func allObjects() -> [SKTilemapObject]`
    + Returns an array containing all objects belonging to a group.
+ **New Property** - *SKTilemapTileData* - `var rawID: Int`
