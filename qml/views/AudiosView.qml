/*
  Copyright (C) 2016 Petr Vytovtov
  Contact: Petr Vytovtov <osanwe@protonmail.ch>
  All rights reserved.

  This file is part of Kat.

  Kat is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Kat is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Kat.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    width: maximumWidth
    height: childrenRect.height

    Column {
        width: parent.width

        Repeater {
            model: audios

            BackgroundItem {
                width: maximumWidth
                height: Theme.itemSizeMedium

                Image {
                    id: playpausebutton
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: Theme.iconSizeMedium
                    height: Theme.iconSizeMedium
                    source: "image://theme/icon-m-sounds"
                }

                Column {
                    anchors.left: playpausebutton.right
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: Theme.paddingMedium

                    Label {
                        width: parent.width
                        height: contentHeight
                        font.bold: true
                        truncationMode: TruncationMode.Fade
                        text: audios.get(index).title
                    }

                    Label {
                        width: parent.width
                        height: contentHeight
                        truncationMode: TruncationMode.Fade
                        text: audios.get(index).artist
                    }
                }

                onClicked: {
                    var urls = []
                    var idx = 0
                    while (idx < audios.count) {
                        urls[idx] = audios.get(idx).url
                        idx++
                    }
                    console.log(urls)
                    player.setPlaylist(urls, index)
                    audioPlayer.playing = true
                    audioPlayer.showControls()
                    audioPlayer._audios = audios
                    audioPlayer._index = index
                    audioPlayer.author = audios.get(index).artist
                    audioPlayer.title = audios.get(index).title
                    audioPlayer.duration = audios.get(index).duration
//                    audioPlayer.setAudios(audios, index)
                }
            }
        }
    }
}
