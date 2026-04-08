/// @function scr_border_set_current()
function scr_border_set_current() {
    var s = global.bd_state;
    if (s.queue_index >= array_length(global.bd_entrants)) {
        s.current = undefined;
        s.last_result = "오늘 심사가 종료되었습니다.";
        return;
    }

    s.current = global.bd_entrants[s.queue_index];
    s.last_result = "판정 대기 중...";
}

/// @function scr_border_push_log(msg)
function scr_border_push_log(msg) {
    array_insert(global.bd_log, 0, msg);
    if (array_length(global.bd_log) > 12) {
        array_resize(global.bd_log, 12);
    }
}

/// @function scr_border_evaluate(approve)
function scr_border_evaluate(approve) {
    var s = global.bd_state;
    if (s.game_over || is_undefined(s.current)) return;

    var rule_index = clamp(s.day - 1, 0, array_length(global.bd_rules) - 1);
    var allow = global.bd_rules[rule_index].checker(s.current);
    var correct = (allow == approve);

    if (correct) {
        s.score += 10;
        s.last_result = "올바른 판정";
        scr_border_push_log("[OK] " + s.current.name + " - 판정 성공");
    } else {
        s.mistakes += 1;
        s.last_result = "잘못된 판정";
        scr_border_push_log("[ERR] " + s.current.name + " - 판정 실패");
    }

    s.queue_index += 1;

    if ((s.queue_index mod 3) == 0 && s.day < 3) {
        s.day += 1;
        scr_border_push_log("[RULE] Day " + string(s.day) + " 규정 업데이트");
    }

    if (s.mistakes >= 3) {
        s.game_over = true;
        s.last_result = "게임 오버";
        scr_border_push_log("[END] 실수 3회 누적 - 게임 오버");
        return;
    }

    scr_border_set_current();
}
