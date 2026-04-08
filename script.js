const state = {
  day: 1,
  score: 0,
  mistakes: 0,
  queueIndex: 0,
  currentEntrant: null,
};

const dayRules = {
  1: {
    text: ["모든 입국자는 유효한 여권이 필요하다."],
    checker: (entrant) => entrant.passportValid,
  },
  2: {
    text: [
      "모든 입국자는 유효한 여권이 필요하다.",
      "콜레치아(Kolechia) 국적은 입국 금지.",
    ],
    checker: (entrant) => entrant.passportValid && entrant.nation !== "Kolechia",
  },
  3: {
    text: [
      "모든 입국자는 유효한 여권이 필요하다.",
      "콜레치아(Kolechia) 국적은 입국 금지.",
      "방문 목적이 'work'이면 취업 허가서가 필요하다.",
    ],
    checker: (entrant) =>
      entrant.passportValid &&
      entrant.nation !== "Kolechia" &&
      (entrant.reason !== "work" || entrant.workPermit),
  },
};

const entrants = [
  { name: "Mina Rafiq", nation: "Arstotzka", reason: "visit", passportValid: true, workPermit: false },
  { name: "Alex Sader", nation: "Kolechia", reason: "visit", passportValid: true, workPermit: false },
  { name: "Yuri Danov", nation: "Impor", reason: "work", passportValid: true, workPermit: false },
  { name: "Nari Han", nation: "Antegria", reason: "work", passportValid: true, workPermit: true },
  { name: "Luka Zina", nation: "Obristan", reason: "transit", passportValid: false, workPermit: false },
  { name: "Sara Mol", nation: "United Fed", reason: "visit", passportValid: true, workPermit: false },
  { name: "Dari Orlov", nation: "Kolechia", reason: "work", passportValid: true, workPermit: true },
  { name: "Ken Ota", nation: "Arstotzka", reason: "work", passportValid: true, workPermit: false },
  { name: "Isha Kim", nation: "Antegria", reason: "work", passportValid: true, workPermit: true },
];

const dayEl = document.getElementById("day");
const scoreEl = document.getElementById("score");
const mistakesEl = document.getElementById("mistakes");
const rulesEl = document.getElementById("rules");
const nameEl = document.getElementById("entrantName");
const nationEl = document.getElementById("entrantNation");
const reasonEl = document.getElementById("entrantReason");
const documentEl = document.getElementById("documentView");
const logList = document.getElementById("logList");
const approveBtn = document.getElementById("approveBtn");
const denyBtn = document.getElementById("denyBtn");
const nextBtn = document.getElementById("nextBtn");

function renderRules() {
  const rules = dayRules[state.day];
  rulesEl.innerHTML = `<strong>오늘의 규정</strong><ul>${rules.text.map((rule) => `<li>${rule}</li>`).join("")}</ul>`;
}

function formatDocument(entrant) {
  return [
    "=== PASSPORT ===",
    `NAME: ${entrant.name}`,
    `NATION: ${entrant.nation}`,
    `PURPOSE: ${entrant.reason}`,
    `VALID: ${entrant.passportValid ? "YES" : "NO"}`,
    `WORK PERMIT: ${entrant.workPermit ? "YES" : "NO"}`,
  ].join("\n");
}

function renderEntrant() {
  const entrant = entrants[state.queueIndex];
  state.currentEntrant = entrant;

  if (!entrant) {
    nameEl.textContent = "근무 종료";
    nationEl.textContent = "-";
    reasonEl.textContent = "-";
    documentEl.textContent = "오늘 심사가 종료되었습니다.";
    approveBtn.disabled = true;
    denyBtn.disabled = true;
    nextBtn.disabled = true;
    return;
  }

  nameEl.textContent = entrant.name;
  nationEl.textContent = entrant.nation;
  reasonEl.textContent = entrant.reason;
  documentEl.textContent = formatDocument(entrant);
  approveBtn.disabled = false;
  denyBtn.disabled = false;
  nextBtn.disabled = true;
}

function appendLog(text) {
  const item = document.createElement("li");
  item.textContent = text;
  logList.prepend(item);
}

function evaluateDecision(playerApproved) {
  const entrant = state.currentEntrant;
  if (!entrant) return;

  const shouldApprove = dayRules[state.day].checker(entrant);
  const correct = shouldApprove === playerApproved;

  if (correct) {
    state.score += 10;
    appendLog(`✅ ${entrant.name}: 올바른 판정`);
  } else {
    state.mistakes += 1;
    appendLog(`❌ ${entrant.name}: 잘못된 판정`);
  }

  approveBtn.disabled = true;
  denyBtn.disabled = true;
  nextBtn.disabled = false;

  state.queueIndex += 1;

  if (state.queueIndex % 3 === 0 && state.day < 3) {
    state.day += 1;
    appendLog(`📜 Day ${state.day} 시작 - 규정이 업데이트되었습니다.`);
    renderRules();
  }

  dayEl.textContent = String(state.day);
  scoreEl.textContent = String(state.score);
  mistakesEl.textContent = String(state.mistakes);

  if (state.mistakes >= 3) {
    appendLog("💀 실수 3회 누적. 게임 오버!");
    nextBtn.disabled = true;
    approveBtn.disabled = true;
    denyBtn.disabled = true;
  }
}

approveBtn.addEventListener("click", () => evaluateDecision(true));
denyBtn.addEventListener("click", () => evaluateDecision(false));
nextBtn.addEventListener("click", () => {
  if (state.mistakes >= 3) return;
  renderEntrant();
});

renderRules();
renderEntrant();
