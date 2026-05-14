import { Gtk } from "ags/gtk4"

export default function Time() {
    return (
        <menubutton $type="end" hexpand halign={Gtk.Align.CENTER}>
        <label label={new Date().toLocaleTimeString()} />
        <popover>
          <Gtk.Calendar />
        </popover>
      </menubutton>
    );
}