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
          width: lc.sizeX
          height: lc.sizeY

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
            Canvas {
              id: canvas
              anchors.fill: parent
              Component.onCompleted: loadImage("../atlas.png")
              onImageLoaded: requestPaint()
              onPaint: drawView()

              function drawView() {
                var ctx = canvas.getContext('2d');
                ctx.save();

                drawGrid(32, 4);

                for (var i = 0; i < lc.objectsLength(); i++) {
                  var objI = lc.objectsG(i);
                  ctx.drawImage(
                    '../atlas.png',
                    objI.spriteX,
                    objI.spriteY,
                    objI.sizeX,
                    objI.sizeY,
                    objI.posX+lc.sizeX/2,
                    -objI.posY+lc.sizeY/2,
                    objI.cusX,
                    objI.cusY
                  );
                }

                ctx.restore();
              }

              function drawGrid(space, dashlength) {
                var ctx = canvas.getContext('2d');
                var offX = (lc.sizeY/2)%space - space;
                var offY = (lc.sizeX/2)%space - space;
                ctx.save();

                ctx.beginPath();

                // horizontal
                for (var i = offX; i < lc.sizeY; i += space) {
                  ctx.moveTo(0, i);

                  for (var j = dashlength; j < lc.sizeX; j += dashlength*2) {
                    ctx.lineTo(j, i);
                    ctx.moveTo(j+dashlength, i);
                  }
                }

                // vertical
                for (var i = offY; i < lc.sizeX; i += space) {
                  ctx.moveTo(i, 0);

                  for (var j = dashlength; j < lc.sizeY; j += dashlength*2) {
                    ctx.lineTo(i, j);
                    ctx.moveTo(i, j+dashlength);
                  }
                }

                ctx.stroke();

                ctx.restore();
              }
            }
          }
        }
      }
    }
  }
}
