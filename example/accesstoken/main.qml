import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import orangefour.qoauthlogin 1.0

ApplicationWindow {
  id: container
  visible: true
  width: 640
  height: 480

  Facebook {
    id: fb
    onTokenReady: txt.text = "Facebook token: " + token
    onError: txt.text = what
  }

  Google {
    id: gg
    onTokenReady: txt.text = "Google token: " + token
    onError: txt.text = what
  }

  ColumnLayout {
    anchors.fill: parent
    Flickable {
      boundsBehavior: Flickable.StopAtBounds
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.preferredHeight: container.height * 3 / 4
      TextArea.flickable: TextArea {
        id: txt
        text: "Push some button"
        readOnly: true
        wrapMode: TextEdit.Wrap
        verticalAlignment: TextEdit.AlignVCenter
        horizontalAlignment: TextEdit.AlignHCenter
      }
    }
    RowLayout {
      Layout.fillWidth: true
      Layout.preferredHeight: container.height / 4
      Button {
        Layout.fillWidth: true
        Layout.fillHeight: true
        text: "Facebook"
        onClicked: {
          fb.login()
        }
      }
      Button {
        Layout.fillWidth: true
        Layout.fillHeight: true
        text: "Google"
        onClicked: {
          gg.login()
        }
      }
    }
  }
}
