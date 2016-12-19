import QtQuick 2.5
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

Window {
  signal ok(
    string Name
  )

  id: addObjWindow
  title: "Add Object"
  width: 180
  height: 200

  ColumnLayout {
    anchors.fill: parent

    Rectangle {
      color: "#ddd"
      Layout.fillWidth: true
      Layout.fillHeight: true

      TextField {
        id: name
        placeholderText: "name" 
        font.pointSize: 14
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        selectByMouse: true
      }
    }

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true

      TextField {
        placeholderText: "type"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        selectByMouse: true
      }
    }

    Rectangle {
      color: "#ddd"
      Layout.fillWidth: true
      Layout.fillHeight: true

      GridLayout { 
        anchors.fill: parent
        columns: 4 

        Text { text: "position"; Layout.columnSpan: 4 }

        Text { text: "x: " }
        TextField {
          Layout.fillWidth: true
          selectByMouse: true
          validator: IntValidator { bottom: 0 }
        }

        Text { text: "y: " }
        TextField {
          Layout.fillWidth: true
          selectByMouse: true
          validator: IntValidator { bottom: 0 }
        }
      }
    }

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true

      GridLayout { 
        anchors.fill: parent
        columns: 4 

        Text { text: "size"; Layout.columnSpan: 4 }

        Text { text: "x: " }
        TextField {
          Layout.fillWidth: true
          selectByMouse: true
          validator: IntValidator { bottom: 0 }
        }

        Text { text: "y: " }
        TextField {
          Layout.fillWidth: true
          selectByMouse: true
          validator: IntValidator { bottom: 0 }
        }
      }
    }

    Rectangle {
      color: "#ddd"
      Layout.fillWidth: true
      Layout.fillHeight: true

      RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
          text: "Ok"
          onClicked: {
            addObjWindow.ok(name.text);
            addObjWindow.close();
          }
        }
        Button {
          text: "Cancel"
          onClicked: addObjWindow.close()
        }
      }
    }
  }
}
