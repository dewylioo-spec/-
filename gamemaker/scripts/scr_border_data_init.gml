/// @function scr_border_data_init()
/// @description Initialize global game state for a Papers, Please-like border desk loop.
function scr_border_data_init() {
    global.bd_state = {
        day: 1,
        score: 0,
        mistakes: 0,
        queue_index: 0,
        game_over: false,
        last_result: "",
        current: undefined
    };

    global.bd_rules = [
        {
            text: ["모든 입국자는 유효한 여권이 필요하다."],
            checker: function(e) {
                return e.passport_valid;
            }
        },
        {
            text: [
                "모든 입국자는 유효한 여권이 필요하다.",
                "콜레치아(Kolechia) 국적은 입국 금지."
            ],
            checker: function(e) {
                return e.passport_valid && e.nation != "Kolechia";
            }
        },
        {
            text: [
                "모든 입국자는 유효한 여권이 필요하다.",
                "콜레치아(Kolechia) 국적은 입국 금지.",
                "방문 목적이 work이면 취업 허가서가 필요하다."
            ],
            checker: function(e) {
                return e.passport_valid && e.nation != "Kolechia" && (e.reason != "work" || e.work_permit);
            }
        }
    ];

    global.bd_entrants = [
        {name: "Mina Rafiq", nation: "Arstotzka", reason: "visit", passport_valid: true, work_permit: false},
        {name: "Alex Sader", nation: "Kolechia", reason: "visit", passport_valid: true, work_permit: false},
        {name: "Yuri Danov", nation: "Impor", reason: "work", passport_valid: true, work_permit: false},
        {name: "Nari Han", nation: "Antegria", reason: "work", passport_valid: true, work_permit: true},
        {name: "Luka Zina", nation: "Obristan", reason: "transit", passport_valid: false, work_permit: false},
        {name: "Sara Mol", nation: "United Fed", reason: "visit", passport_valid: true, work_permit: false},
        {name: "Dari Orlov", nation: "Kolechia", reason: "work", passport_valid: true, work_permit: true},
        {name: "Ken Ota", nation: "Arstotzka", reason: "work", passport_valid: true, work_permit: false},
        {name: "Isha Kim", nation: "Antegria", reason: "work", passport_valid: true, work_permit: true}
    ];

    global.bd_log = [];
}
