import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 800
    height: 480
    color: "black"

    Rectangle {
        id: mainScreen
        width: 800
        height: 480
        color: "black"

        Rectangle {
            id: header
            width: mainScreen.width
            height: 50
            color: "black"

            anchors {
                top: mainScreen.top
                left: mainScreen.left
                right: mainScreen.right
            }

            Text {
                id: nameofgame
                text: "Dark Fairytale"
                color: "white"
                font.pixelSize: 40
                anchors {
                    verticalCenter: header.verticalCenter
                    left: header.left
                }
            }

            Rectangle {
                id: buttonstart
                objectName: "buttonstart"
                height: 40
                width: 100
                color: "black"
                border.color: "white"
                border.width: 2
                radius: 5

                Text {
                    text: buttonstart.bGameStarted ? "Spiel stoppen" : "Spiel starten"
                    color: "white"
                    horizontalAlignment: Text.Center
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                }

                property bool bGameStarted: false

                signal clicked(bool bGameStarted);

                function toogle() {
                    console.log(bGameStarted)
                    if(buttonstart.state == "start")
                        buttonstart.state = "finish";
                    else
                        buttonstart.state = "start"
                }

                anchors {
                    left: nameofgame.right
                    verticalCenter: header.verticalCenter
                    leftMargin: 70
                }

                MouseArea {
                    anchors.fill:  buttonstart
                    onClicked: {
                        buttonstart.toogle();
                        buttonstart.clicked(buttonstart.bGameStarted);}
                }

                states: [
                    State {
                        name: "start"
                        PropertyChanges { target: buttonstart; bGameStarted: true; }
                    },
                    State {
                        name: "finish"
                        PropertyChanges { target: buttonstart; bGameStarted: false; }
                    }

                ]
            }

            Rectangle {
                id: buttonreset
                objectName: "buttonreset"
                height: 40
                width: 100
                border.color: "white"
                border.width: 1
                color: "black"
                radius: 5

                Text {
                    text: "Reset"
                    color: "white"
                    horizontalAlignment: Text.Center
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                }

                signal clicked();

                MouseArea {
                    anchors.fill: buttonreset
                    onClicked: {buttonreset.clicked();}
                }

                anchors {
                    verticalCenter: header.verticalCenter
                    left: buttonstart.right
                    leftMargin: 20
                }
            }

            Text {

                property string stringTimer: "60:00:00"

                id: timer
                objectName: "timer"
                text: stringTimer
                color: "white"
                font.pixelSize: 40

                anchors {
                    verticalCenter: header.verticalCenter
                    right: header.right
                }
            }

        }

        Item {
            id: content
            width: mainScreen.width

            anchors {
                top: header.bottom
                left: mainScreen.left
                right: mainScreen.right
                bottom: mainScreen.bottom
            }

            Item {
                id: players
                width: content.width * 0.7

                anchors {
                    top: content.top
                    left: content.left
                    right: queststatus.left
                    bottom: content.bottom
                }

                Image {
                    id: player1
                    objectName: "player1"

                    property bool player1_status: false

                    source: player1.player1_status ? "/media/sf_vf_geteilterOrdner/characters/character_death.png" : "/media/sf_vf_geteilterOrdner/characters/character_death_grey-01.png"

                    anchors {
                        top: players.top
                        left: players.left
                        right: players.horizontalCenter
                        bottom: players.verticalCenter
                    }
                }

                Image {
                    id: player2
                    objectName: "player2"

                    property bool player2_status: false

                    source: player2.player2_status ? "/media/sf_vf_geteilterOrdner/characters/character_fairy.png" : "/media/sf_vf_geteilterOrdner/characters/character_fairy_grey.png"

                    anchors {
                        top: players.top
                        left: players.horizontalCenter
                        right: players.right
                        bottom: players.verticalCenter
                    }
                }

                Image {
                    id: player3
                    objectName: "player3"

                    property bool player3_status: false

                    source: player3.player3_status ? "/media/sf_vf_geteilterOrdner/characters/character_mage.png" : "/media/sf_vf_geteilterOrdner/characters/character_mage_grey-01.png"

                    anchors {
                        top: players.verticalCenter
                        left: players.left
                        right: players.horizontalCenter
                        bottom: players.bottom
                    }
                }

                Image {
                    id: player4
                    objectName: "player4"

                    property bool player4_status: false

                    source: player4.player4_status ? "/media/sf_vf_geteilterOrdner/characters/character_vampire.png" : "/media/sf_vf_geteilterOrdner/characters/character_vampire_grey-01.png"

                    anchors {
                        top: players.verticalCenter
                        left: players.horizontalCenter
                        right: players.right
                        bottom: players.bottom
                    }
                }
            }

            Rectangle {
                id: queststatus

                property int iValueRightMargin: 25
                property int iValueHeight: 50

                height: 50
                color: "black"
//                Text {
//                    id: queststatus_text
//                    text: "Erfolge"
//                    color: "white"
//                    height: 20
//                }

                anchors {
                    top: content.top
                    left: players.right
                    right: content.right
                }
            }

            Item {
                id: quest1_item
                objectName: "quest1_item"
                height: queststatus.iValueHeight

                property bool bquest1_status: false

                anchors {
                    top: queststatus.bottom
                    left: players.right
                    right: content.right
                }

                Text {
                    id: quest1_text
                    text: "Wer zur Hölle bin ich eigentlich?"
                    color: "white"
                    anchors {
                        left: quest1_item.left
                    }
                }


                Rectangle {
                    id: quest1_status

                    height: 10
                    width: height
                    radius: height * 0.5
                    color: quest1_item.bquest1_status ? "green" : "red"
                    anchors {
                        right: quest1_item.right
                        rightMargin: queststatus.iValueRightMargin
                    }
                }
            }

            Item {
                id: quest2_item
                objectName: "quest2_item"
                height: queststatus.iValueHeight

                property bool bquest2_status: false

                anchors {
                    top: quest1_item.bottom
                    left: players.right
                    right: content.right
                }

                Text {
                    id: quest2_text
                    text: "Das Blutbad"
                    color: "white"
                    anchors {
                        left: quest2_item.left
                    }
                }


                Rectangle {
                    id: quest2_status
                    height: 10
                    width: height
                    radius: height * 0.5
                    color: quest2_item.bquest2_status ? "green" : "red"
                    anchors {
                        right: quest2_item.right
                        rightMargin: queststatus.iValueRightMargin
                    }
                }
            }

            Item {
                id: quest3_item
                objectName: "quest3_item"
                height: queststatus.iValueHeight

                property bool bquest3_status: false

                anchors {
                    top: quest2_item.bottom
                    left: players.right
                    right: content.right
                }

                Text {
                    id: quest3_text
                    text: "Ich bin ein glitzender Vampir"
                    color: "white"
                    anchors {
                        left: quest3_item.left
                    }
                }


                Rectangle {
                    id: quest3_status
                    height: 10
                    width: height
                    radius: height * 0.5
                    color: quest3_item.bquest3_status ? "green" : "red"
                    anchors {
                        right: quest3_item.right
                        rightMargin: queststatus.iValueRightMargin
                    }
                }
            }

            Item {
                id: quest4_item
                objectName: "quest4_item"
                height: queststatus.iValueHeight

                property bool bquest4_status: false

                anchors {
                    top: quest3_item.bottom
                    left: players.right
                    right: content.right
                }

                Text {
                    id: quest4_text
                    text: "Abra-Kadabra-Simsala Bim"
                    color: "white"
                    anchors {
                        left: quest4_item.left
                    }
                }


                Rectangle {
                    id: quest4_status
                    height: 10
                    width: height
                    radius: height * 0.5
                    color: quest4_item.bquest4_status ? "green" : "red"
                    anchors {
                        right: quest4_item.right
                        rightMargin: queststatus.iValueRightMargin
                    }
                }
            }

            Item {
                id: quest5_item
                objectName: "quest5_item"
                height: queststatus.iValueHeight

                property bool bquest5_status: false

                anchors {
                    top: quest4_item.bottom
                    left: players.right
                    right: content.right
                }

                Text {
                    id: quest5_text
                    text: "Die Kehrmaschine des Todes"
                    color: "white"
                    anchors {
                        left: quest5_item.left
                    }
                }


                Rectangle {
                    id: quest5_status
                    height: 10
                    width: height
                    radius: height * 0.5
                    color: quest5_item.bquest5_status ? "green" : "red"
                    anchors {
                        right: quest5_item.right
                        rightMargin: queststatus.iValueRightMargin
                    }
                }
            }
        }


    }
}
