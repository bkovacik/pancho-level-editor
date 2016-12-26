// REFACTOR DUPLICATE GROUPS INTO A CUSTOM OBJECT TO DRY THIS UP
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

ApplicationWindow {
  id: appWindow
  minimumWidth: 640
  minimumHeight: 480

  RowLayout {
    anchors.fill: parent

    ColumnLayout {
      id: info
      Layout.maximumWidth: 200
      Layout.maximumHeight: 200
      anchors.fill: parent

      Rectangle {
        color: "#ddd"
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
          text: object.name 
          font.pointSize: 14
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
        }
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
          text: "type: " + object.type
          anchors.verticalCenter: parent.verticalCenter
        }
      }

      Rectangle {
        color: "#ddd"
        Layout.fillWidth: true
        Layout.fillHeight: true
     
        GridLayout { 
          columns: 2
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.left: parent.left

          Text { text: "position"; Layout.columnSpan: 2; }
          Text { text: "x: " + object.posX }
          Text {
            text: "y: " + object.posY
            anchors.right: parent.right
          }
        }
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
     
        GridLayout { 
          columns: 2
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.left: parent.left

          Text { text: "size"; Layout.columnSpan: 2; }
          Text { text: "x: " + object.sizeX }
          Text {
            text: "y: " + object.sizeY
            anchors.right: parent.right
          }
        }
      }
    }

    Rectangle {
      id: scroll
      color: "transparent"
      Layout.fillWidth: true
      Layout.fillHeight: true

      ScrollView {
        width: Math.min(mapview.width+20, scroll.width)
        height: Math.min(mapview.height+20, scroll.height)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
          id: mapview
          color: "#555"
          width: 600
          height: 400

          MouseArea {
            anchors.fill: parent
            onClicked: {
              addObj.source = "Popup.qml";
              addObj.item.show();
            }
            Loader { id: addObj }
            Connections {
              target: addObj.item
              onOk: {
                object.name = Name;
              } 
            }
          }
        }
      }
    }
  }
}
