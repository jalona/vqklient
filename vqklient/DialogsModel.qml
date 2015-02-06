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
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import QtQuick.Controls 1.3 as Controls
import Material 0.1 as Material
import Material 0.1
//import Material.Transitions 0.1 as Transitions
//import QtQuick.Controls 1.3

ListModel{
    id: dialogsModel
    ListElement{
        author: "Egor Matirov"
        message: "Hello..."
        image: "http://pp.vk.me/c606126/v606126545/6982/KvN_vQzI5lM.jpg"
        time: "12:43"
    }
    ListElement{
        author: "1"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "2"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "3"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "4"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "5"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "6"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "7"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "8"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "9"
        message: "Testing..."
        image: "http://vk.com/images/camera_b.gif"
        time: "yesterday"
    }
    ListElement{
        author: "Ололоша"
        message: "Хм, кажется, оно работает. Прикольно..."
        image: "http://vk.com/images/camera_b.gif"
        time: "tomorrow"
    }
}
