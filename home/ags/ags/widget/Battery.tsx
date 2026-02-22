import AstalBattery from "gi://AstalBattery"
import {createBinding} from 'ags';

export default function Battery() {

    const battery = AstalBattery.get_default();
    const percentage = createBinding(
        battery,
        'percentage'
    )((p => {

        return `${Math.floor(p * 100)}%`}));

    return (
        <label label={percentage} />
    );

}