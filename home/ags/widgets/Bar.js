const hyprland = await Service.import("hyprland")
const battery = await Service.import("battery")

const date = Variable("", {
    poll: [1000, 'date "+%H:%M"'],
})

const dispatch = (ws) => hyprland.messageAsync(`dispatch workspace ${ws}`);

function Workspaces() {
    const activeId = hyprland.active.workspace.bind("id");
    const workspaces = hyprland.bind("workspaces").as(ws => {
        const maxId = Math.max(...ws.map(({ id }) => id), 0); // Find the highest workspace ID

        // Create buttons for all workspaces from 1 to maxId
        return Array.from({ length: maxId }, (_, i) => i + 1).map(id => {
            const workspace = ws.find(w => w.id === id) || { windows: 0 }; // Default to empty workspace if not found

            return Widget.Button({
                on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
                //child: Widget.Label(`${id}`),
                setup: self => self.hook(hyprland, () => {
                     self.toggleClassName("active", hyprland.active.workspace.id === id)
                     self.toggleClassName("occupied", (hyprland.getWorkspace(id)?.windows || 0) > 0)
                }),
            });
        });
    });

    return Widget.EventBox({
        onScrollUp: () => hyprland.messageAsync('dispatch workspace +1'),
        onScrollDown: () => hyprland.messageAsync('dispatch workspace -1'),
        child: Widget.Box({
            class_name: "workspaces",
            children: workspaces,
            vpack: "center",
            hexpand: false,
            vexpand: false,
            spacing: 4,
        }),
    });
}

function Clock() {
    return Widget.Label({
        class_name: "clock",
        label: date.bind(),
        hpack: "start",
    })
}

function BatteryLabel() {
    const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
    const icon = battery.bind("percent").as(p =>
        `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

    return Widget.Box({
        class_name: "battery",
        visible: battery.bind("available"),
        hpack: "end",
        spacing: 4,
        children: [
            Widget.Icon({ icon }),
            Widget.LevelBar({
                widthRequest: 140,
                value,
            }),
        ],
    })
}


export default function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Clock(),
            center_widget: Workspaces(),
            end_widget: BatteryLabel(),
        }),
    })
}

