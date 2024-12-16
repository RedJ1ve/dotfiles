import { Variable, GLib, bind } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import Battery from "gi://AstalBattery"

function BatteryLevel() {
    const bat = Battery.get_default()

    return <box className="Battery"
        visible={bind(bat, "isPresent")}>
        <icon icon={bind(bat, "batteryIconName")} />
        <label label={bind(bat, "percentage").as(p =>
            `${Math.floor(p * 100)} %`
        )} />
    </box>
}

function Workspaces() {
    const hypr = Hyprland.get_default();

    return (
        <box className="Workspaces">
            {bind(hypr, "workspaces").as(wss => {
                // Get the range of workspace IDs
                const occupiedIds = wss.map(ws => ws.id);
                const minId = Math.min(...occupiedIds);
                const maxId = Math.max(...occupiedIds);

                // Generate all IDs in the range [minId, maxId]
                const allIds = Array.from({ length: maxId - minId + 1 }, (_, i) => minId + i);

                return allIds.map(id => {
                    const ws = wss.find(ws => ws.id === id);

                    return (
                        <button
                             className={bind(hypr, "focusedWorkspace").as(fw => {
                                if (ws) {
                                    if (ws === fw) return "focused"; // Apply "focused" if it's the focused workspace
                                    return "occupied"; // Apply "occupied" if it's an occupied but not focused workspace
                                }
                                return ""; // No class for unoccupied workspaces
                            })}                           
                            onClicked={() => hypr.dispatch("workspace", String(id))}>
			    {id}
                        </button>
                    );
                });
            })}
        </box>
    );
}

function Time({ format = "%H:%M" }) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        className="Time"
        onDestroy={() => time.drop()}
        label={time()}
    />
}

export default function Bar(monitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        className="Bar"
        gdkmonitor={monitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}>
        <centerbox>
            <box hexpand halign={Gtk.Align.START}>
		<Time />
            </box>
            <box>
                <Workspaces />
            </box>
            <box hexpand halign={Gtk.Align.END} >
                <BatteryLevel />
            </box>
        </centerbox>
    </window>
}
