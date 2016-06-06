import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

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
      anchors.left: parent.left
      anchors.top: parent.top

      Rectangle {
        color: "#DDD"
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
          text: "--Name--"
          font.pointSize: 14
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
        }
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
          text: "Type:"
          anchors.verticalCenter: parent.verticalCenter
        }
      }

      Rectangle {
        color: "#DDD"
        Layout.fillWidth: true
        Layout.fillHeight: true
     
        GridLayout { 
          columns: 2
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.left: parent.left

          Text { text: "Position"; Layout.columnSpan: 2; }
          Text { text: "x:";  }
          Text {
            text: "y:"
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

          Text { text: "Size"; Layout.columnSpan: 2; }
          Text { text: "x:" }
          Text {
            text: "y:"
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
        }
      }
    }
  }
}
