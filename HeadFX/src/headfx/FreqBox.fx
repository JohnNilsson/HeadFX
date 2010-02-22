/*
 * FreqBox.fx
 *
 * Created on 2010-feb-21, 21:34:12
 */
package headfx;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;
import javafx.scene.shape.Rectangle;
import javafx.util.Math.*;
import javafx.geometry.BoundingBox;
import javafx.scene.layout.Resizable;
import javafx.scene.input.KeyCode;

/**
 * @author John
 */
public class FreqBox extends CustomNode, Resizable {

    public var bgColor = Color.BLACK;
    public var lineColor = Color.WHITE;
    public var eqColor = Color.YELLOW;
    public var cursorColor = Color.RED;
    def minFreq = log10(20);
    def maxFreq = log10(20000);
    def freqRes = 300.0;
    def freqStep = (maxFreq - minFreq) / freqRes;
    var currFreq = minFreq;

    public function lowerFrequency() {
        if (currFreq > minFreq) {
            currFreq -= freqStep;
            }
    }

    public function raiseFrequency() {
        if (currFreq < maxFreq) {
            currFreq += freqStep;
            }
    }

    public function raiseGain() {
    }

    public function lowerGain() {
    }

    override protected function create(): Node {
        Group {
            content: [
                Rectangle {
                    width: bind width
                    height: bind height
                    fill: Color.BLACK
                },
                lineSegment(20, 100, 10, lineColor),
                lineSegment(100, 1000, 100, lineColor),
                lineSegment(1000, 10000, 1000, lineColor),
                Line {
                    startX: 0, startY: bind height / 2
                    endX: bind width, endY: bind height / 2
                    strokeWidth: 1
                    stroke: lineColor
                },
                Line {
                    var x = bind freqToCoord(currFreq)
                    startX: bind x, startY: 0
                    endX: bind x, endY: bind height
                    strokeWidth: 5
                    stroke: cursorColor
                    opacity: 0.6
                }
            ]
            focusTraversable: true
            onKeyPressed: function (event) {
                if (event.code == KeyCode.VK_LEFT) {
                    lowerFrequency();
                    } else if (event.code == KeyCode.VK_RIGHT) {
                    raiseFrequency();
                    } else if (event.code == KeyCode.VK_UP) {
                    raiseGain();
                    } else if (event.code == KeyCode.VK_DOWN) {
                    lowerGain();
                    }
            }
        }
    }

    bound function freqToCoord(freq:Double) {
        return width * (freq-minFreq) / (maxFreq - minFreq)
    }


    function lineSegment(low: Double, high: Double, stp: Double, color: Color): Node[] {
        for (hz in [low..high step stp]) {
            var x = bind freqToCoord(log10(hz));
            Line {
                startX: bind x, startY: 0
                endX: bind x, endY: bind height
                strokeWidth: 1
                stroke: color
            }
        }
    }

    override public function getPrefHeight(fitHeight: Number): Number {
        fitHeight;
    }

    override public function getPrefWidth(fitWidth: Number): Number {
        fitWidth;
    }

    override var layoutBounds = bind

lazy BoundingBox{
            minX:0 minY:0 width:width height:height
            }
}
