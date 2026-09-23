// Kuromi pixel doldurma oyunu
// Grid: 0 = boş (arka plan), 1..4 = boyanacak renk kodu

const GRID = [
  [0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0],
  [0,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,4,0,0,0],
  [0,0,0,0,0,1,1,1,1,0,2,0,1,1,1,1,4,4,0,0,0],
  [0,0,0,0,0,1,1,1,1,2,2,2,1,1,1,1,0,0,0,0,0],
  [0,0,0,0,1,1,1,1,1,2,2,2,1,1,1,1,1,0,0,0,0],
  [0,0,0,0,1,1,1,1,2,2,2,2,2,1,1,1,1,0,0,0,0],
  [0,0,0,0,1,1,1,2,2,2,2,2,2,2,1,1,1,0,0,0,0],
  [0,0,0,1,1,1,2,2,2,2,2,2,2,2,2,1,1,1,0,0,0],
  [0,0,0,1,1,1,2,2,2,2,2,2,2,2,2,1,1,1,0,0,0],
  [0,0,0,1,1,2,2,2,2,2,2,2,2,2,2,2,1,1,0,0,0],
  [0,0,0,1,1,2,2,2,2,2,2,2,2,2,2,2,1,1,0,0,0],
  [0,0,0,1,1,2,2,2,2,2,2,2,2,2,2,2,1,1,0,0,0],
  [0,0,0,1,1,2,2,2,2,2,2,2,2,2,2,2,1,1,0,0,0],
  [0,0,0,1,1,2,2,2,2,2,2,2,2,2,2,2,1,1,0,0,0],
  [0,0,0,1,1,2,2,1,2,2,2,2,2,1,2,2,1,1,0,0,0],
  [0,0,0,1,1,1,2,2,2,2,2,2,2,2,2,1,1,1,0,0,0],
  [0,0,0,1,1,1,3,2,2,2,2,2,2,2,3,1,1,1,0,0,0],
  [0,0,0,0,1,1,1,2,2,2,2,2,2,2,1,1,1,0,0,0,0],
  [0,0,0,0,1,1,1,1,2,2,2,2,2,1,1,1,1,0,0,0,0],
  [0,0,0,0,0,1,1,1,0,1,1,1,0,1,1,1,0,0,0,0,0],
  [0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0],
];

const COLORS = {
  1: { name: "Siyah", hex: "#1b1a1f" },
  2: { name: "Beyaz", hex: "#f7eef4" },
  3: { name: "Pembe", hex: "#ff8fbf" },
  4: { name: "Mor", hex: "#8b4fd1" },
};

const ROWS = GRID.length;
const COLS = GRID[0].length;

const boardEl = document.getElementById("board");
const paletteEl = document.getElementById("palette");
const progressFillEl = document.getElementById("progressFill");
const progressTextEl = document.getElementById("progressText");
const mistakeCountEl = document.getElementById("mistakeCount");
const winOverlayEl = document.getElementById("winOverlay");
const winStatsEl = document.getElementById("winStats");
const resetBtn = document.getElementById("resetBtn");
const playAgainBtn = document.getElementById("playAgainBtn");

boardEl.style.setProperty("--cols", COLS);

let selectedColor = null;
let mistakes = 0;
let filledCount = 0;
let totalCount = 0;
let cellEls = [];

function buildBoard() {
  boardEl.innerHTML = "";
  cellEls = [];
  totalCount = 0;
  filledCount = 0;
  mistakes = 0;
  selectedColor = null;

  for (let r = 0; r < ROWS; r++) {
    for (let c = 0; c < COLS; c++) {
      const value = GRID[r][c];
      const btn = document.createElement("button");
      btn.type = "button";
      btn.dataset.row = r;
      btn.dataset.col = c;
      btn.dataset.value = value;

      if (value === 0) {
        btn.className = "cell cell--empty";
        btn.tabIndex = -1;
        btn.setAttribute("aria-hidden", "true");
      } else {
        btn.className = "cell cell--unfilled";
        btn.setAttribute("role", "gridcell");
        btn.setAttribute("aria-label", `${COLORS[value].name} kare`);
        btn.addEventListener("click", () => handleCellClick(btn, value));
        totalCount++;
      }

      boardEl.appendChild(btn);
      cellEls.push(btn);
    }
  }

  updateProgress();
  mistakeCountEl.textContent = "0";
  winOverlayEl.classList.add("hidden");
}

function buildPalette() {
  paletteEl.innerHTML = "";
  Object.entries(COLORS).forEach(([code, info]) => {
    const remaining = countRemaining(Number(code));
    const swatch = document.createElement("button");
    swatch.type = "button";
    swatch.className = "swatch";
    swatch.dataset.code = code;
    swatch.setAttribute("role", "option");
    swatch.innerHTML = `
      <span class="swatch__dot" style="background:${info.hex}"></span>
      <span>${info.name}</span>
      <span class="swatch__count" data-count-for="${code}">${remaining}</span>
    `;
    swatch.addEventListener("click", () => selectColor(Number(code), swatch));
    paletteEl.appendChild(swatch);
  });
}

function countRemaining(code) {
  let count = 0;
  for (let r = 0; r < ROWS; r++) {
    for (let c = 0; c < COLS; c++) {
      if (GRID[r][c] === code) count++;
    }
  }
  return count;
}

function selectColor(code, swatchEl) {
  selectedColor = code;
  document.querySelectorAll(".swatch").forEach((el) => el.classList.remove("is-selected"));
  swatchEl.classList.add("is-selected");
}

function handleCellClick(btn, value) {
  if (btn.classList.contains("cell--filled")) return;

  if (selectedColor === null) {
    flashPalette();
    return;
  }

  if (selectedColor !== value) {
    mistakes++;
    mistakeCountEl.textContent = String(mistakes);
    btn.classList.add("cell--wrong");
    setTimeout(() => btn.classList.remove("cell--wrong"), 280);
    return;
  }

  btn.classList.remove("cell--unfilled");
  btn.classList.add("cell--filled");
  btn.style.background = COLORS[value].hex;
  filledCount++;

  updateSwatchCount(value);
  updateProgress();

  if (filledCount === totalCount) {
    onWin();
  }
}

function updateSwatchCount(code) {
  const remainingCells = boardEl.querySelectorAll(
    `.cell[data-value="${code}"]:not(.cell--filled)`
  ).length;
  const countEl = paletteEl.querySelector(`[data-count-for="${code}"]`);
  if (countEl) countEl.textContent = String(remainingCells);
}

function flashPalette() {
  paletteEl.animate(
    [{ transform: "translateX(-2px)" }, { transform: "translateX(2px)" }, { transform: "translateX(0)" }],
    { duration: 200 }
  );
}

function updateProgress() {
  const pct = totalCount === 0 ? 0 : Math.round((filledCount / totalCount) * 100);
  progressFillEl.style.width = `${pct}%`;
  progressTextEl.textContent = `${pct}%`;
}

function onWin() {
  winStatsEl.textContent = `${totalCount} kare, ${mistakes} hata ile tamamlandı.`;
  winOverlayEl.classList.remove("hidden");
}

function resetGame() {
  buildBoard();
  buildPalette();
}

resetBtn.addEventListener("click", resetGame);
playAgainBtn.addEventListener("click", resetGame);

resetGame();
