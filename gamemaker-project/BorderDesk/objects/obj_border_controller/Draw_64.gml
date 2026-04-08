// obj_border_controller : Draw GUI Event
var s = global.bd_state;
var x = ui_x;
var y = ui_y;

// Background panel
var w = display_get_gui_width() - 64;
var h = display_get_gui_height() - 48;
draw_set_alpha(0.85);
draw_set_color(make_color_rgb(20, 20, 20));
draw_roundrect(x - 12, y - 12, x + w, y + h, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_text(x, y, "국경 심사대 프로토타입 (GameMaker)");
y += line_h;
draw_text(x, y, "A: 승인  D: 거부  R: 리셋");
y += line_h;
draw_text(x, y, "Day " + string(s.day) + " | Score " + string(s.score) + " | Mistakes " + string(s.mistakes) + "/3");
y += line_h * 2;

var rule_index = clamp(s.day - 1, 0, array_length(global.bd_rules) - 1);
draw_text(x, y, "오늘의 규정:");
y += line_h;
for (var i = 0; i < array_length(global.bd_rules[rule_index].text); i++) {
    draw_text(x + 16, y, "- " + global.bd_rules[rule_index].text[i]);
    y += line_h;
}

y += 8;
if (is_undefined(s.current)) {
    draw_text(x, y, "현재 입국자: 없음");
} else {
    draw_text(x, y, "이름: " + s.current.name); y += line_h;
    draw_text(x, y, "국적: " + s.current.nation); y += line_h;
    draw_text(x, y, "목적: " + s.current.reason); y += line_h;
    draw_text(x, y, "여권 유효: " + string(s.current.passport_valid)); y += line_h;
    draw_text(x, y, "취업 허가서: " + string(s.current.work_permit));
}

y += line_h * 2;
draw_text(x, y, "최근 결과: " + s.last_result);
y += line_h * 2;

draw_text(x, y, "로그:");
y += line_h;
for (var j = 0; j < array_length(global.bd_log); j++) {
    draw_text(x + 16, y, global.bd_log[j]);
    y += 22;
}

if (s.game_over) {
    draw_set_color(make_color_rgb(255, 120, 120));
    draw_text(display_get_gui_width() * 0.5 - 90, 20, "GAME OVER");
    draw_set_color(c_white);
}
