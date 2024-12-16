import { App } from "astal/gtk3"
import { exec, monitorFile } from "astal"
import Bar from "./widgets/Bar"

const colors = "/etc/nixos/home/ags/colors.scss"

const scss = "/etc/nixos/home/ags/style.scss" // Path to you style file
const css = "/tmp/style.css" // Could be anywhere else
compileScss() // Have to pre-compile the SCSS when starting up

monitorFile(
    scss,
    // reload function
    () => {
        console.log("CSS RELOADED") // For debug purpose only
        compileScss()
        App.reset_css() // Have to reset the whole CSS before applying new one
        App.apply_css(css) // Apply newly compiled CSS to the running App
    }
)

monitorFile(
    colors,
    // reload function
    () => {
        console.log("COLORS RELOADED") // For debug purpose only
        compileScss()
        App.reset_css() // Have to reset the whole CSS before applying new one
        App.apply_css(css) // Apply newly compiled CSS to the running App
    }
)

App.start({
    css: css,
    instanceName: "js",
    requestHandler(request, res) {
        print(request)
        res("ok")
    },
    main: () => App.get_monitors().map(Bar),
})

function compileScss() {
    const error = exec(`sass ${scss} ${css}`) // Command to compile the SCSS file into the CSS file
    if (error) {
        console.error(`There went something wrong compiling the SCSS: ${error}`)
    }
}
