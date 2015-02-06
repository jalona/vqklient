/**
 * This file is part of VQKlient.
 * VQK is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright (C) 2015 Mikhail Ivchenko <ematirov@gmail.com>
**/

import QtQuick 2.4

Item {
    id: expandAnimation
    property var target: Item{}
    property int duration: 400
    property bool opened: false
    property int fromWidth: 0
    property int toWidth: 0
    property int fromHeight: 0
    property int toHeight: 0
    property int fromX: 0
    property int toX: 0
    property int fromY: 0
    property int toY: 0

    function start() {
        animX.start();
        animY.start();
        animHeight.start();
        animWidth.start();
    }

    NumberAnimation {
        id: animX
        target: expandAnimation.target
        property: "x"
        duration: expandAnimation.duration
        to: expandAnimation.opened ? expandAnimation.fromX : expandAnimation.toX
        easing.type: Easing.OutCubic
    }
    
    NumberAnimation {
        id: animY
        target: expandAnimation.target
        property: "y"
        duration: expandAnimation.duration
        to: expandAnimation.opened ? expandAnimation.fromY : expandAnimation.toY
        easing.type: Easing.OutCubic
    }
    
    NumberAnimation {
        id: animWidth
        target: expandAnimation.target
        property: "width"
        duration: expandAnimation.duration
        to: expandAnimation.opened ? expandAnimation.fromWidth : expandAnimation.toWidth
        easing.type: Easing.OutCubic
    }
    
    NumberAnimation {
        id: animHeight
        target: expandAnimation.target
        property: "height"
        duration: expandAnimation.duration
        to: expandAnimation.opened ? expandAnimation.fromHeight : expandAnimation.toHeight
        easing.type: Easing.OutCubic
        onStopped: {
            expandAnimation.opened = !expandAnimation.opened;
            expandAnimation.target.visible = expandAnimation.opened;
            if ( expandAnimation.opened ) {
                expandAnimation.target.anchors.fill = expandAnimation.target.parent;
            }
        }
    }
}
