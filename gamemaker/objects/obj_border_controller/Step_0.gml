// obj_border_controller : Step Event
if (keyboard_check_pressed(vk_a)) {
    scr_border_evaluate(true);
}

if (keyboard_check_pressed(vk_d)) {
    scr_border_evaluate(false);
}

if (keyboard_check_pressed(vk_r)) {
    scr_border_data_init();
    scr_border_set_current();
}
