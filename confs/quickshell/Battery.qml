import Quickshell.Services.UPower
import QtQuick
import "./config.js" as Config

Text {
    readonly property real pct: 100 * UPower.displayDevice.percentage
    readonly property color statusColor: UPower.onBattery ? (pct < Config.battery.critical ? Config.battery.low : Config.battery.normal) : Config.battery.charging

    text: `battery: ${Math.round(pct)}%${UPower.onBattery ? "" : "[+]"}`
    color: statusColor
    font.pixelSize: Config.battery.fontSize
}
