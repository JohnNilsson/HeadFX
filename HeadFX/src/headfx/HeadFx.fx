/*
 * HeadFx.fx
 *
 * Created on 2010-feb-21, 21:57:15
 */
package headfx;

import javafx.stage.Stage;
import javafx.scene.Scene;

/**
 * @author John
 */
def freqBox: FreqBox = FreqBox {
            width: bind scene.width
            height: bind scene.height
        }
def scene: Scene = Scene {
            width: 800
            height: 200
            content: [
                freqBox
            ]
        }

Stage {
    title: "HeadFX"
    scene: scene
}
