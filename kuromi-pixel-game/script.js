// Kuromi Pixel Doldurma — çok seviyeli renk-numarasıyla-boyama oyunu
// Her seviye: { id, name, grid, colors } — grid 0 = boş, diğer değerler colors anahtarlarına karşılık gelir.

const LEVELS = [
  {
    id: "kuromi",
    name: "Kuromi",
    colors: {
      1: { name: "Siyah", hex: "#1b1a1f" },
      2: { name: "Beyaz", hex: "#f7eef4" },
      3: { name: "Pembe", hex: "#ff8fbf" },
      4: { name: "Mor", hex: "#8b4fd1" },
    },
    grid: [
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
    ],
  },
  {
    id: "cat",
    name: "Beyaz Kedi",
    colors: {
      1: { name: "Siyah", hex: "#1b1a1f" },
      2: { name: "Beyaz", hex: "#ffffff" },
      3: { name: "Pembe", hex: "#ffb6d9" },
      5: { name: "Mavi", hex: "#4fa8e0" },
    },
    grid: [
      [0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0],
      [0,0,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,0,0],
      [0,0,2,3,2,0,0,0,0,0,0,0,0,0,0,0,2,3,2,0,0],
      [0,0,2,3,2,0,0,0,0,0,0,0,0,0,0,0,2,3,2,0,0],
      [0,2,2,3,3,2,0,0,0,0,2,0,0,0,0,2,3,3,2,2,0],
      [0,2,3,3,3,2,0,2,2,2,2,2,2,2,0,2,3,3,3,2,0],
      [0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,0],
      [0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,0],
      [0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0],
      [0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0],
      [0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0],
      [0,0,2,2,2,2,5,1,5,2,2,2,5,1,5,2,2,2,2,0,0],
      [0,0,2,2,2,2,5,1,5,2,2,2,5,1,5,2,2,2,2,0,0],
      [0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0],
      [0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0],
      [0,0,0,2,2,2,2,2,2,2,3,2,2,2,2,2,2,2,0,0,0],
      [0,0,0,2,2,2,2,2,1,1,2,1,1,2,2,2,2,2,0,0,0],
      [0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,0],
      [0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,0,0,0,0,0],
      [0,0,0,0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0],
    ],
  },
  {
    id: "frame",
    name: "Çerçeve",
    colors: {
      6: { name: "Altın", hex: "#caa472" },
      7: { name: "Koyu Altın", hex: "#8a6a3a" },
      2: { name: "Krem", hex: "#fff3e6" },
      3: { name: "Kalp", hex: "#ff5c8a" },
    },
    grid: [
      [6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6],
      [6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6],
      [6,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6],
      [6,6,7,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,3,3,3,2,3,3,3,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,3,3,3,3,3,3,3,3,3,2,2,2,7,6,6],
      [6,6,7,2,2,2,3,3,3,3,3,3,3,3,3,2,2,2,7,6,6],
      [6,6,7,2,2,2,3,3,3,3,3,3,3,3,3,2,2,2,7,6,6],
      [6,6,7,2,2,2,3,3,3,3,3,3,3,3,3,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,3,3,3,3,3,3,3,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,3,3,3,3,3,3,3,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,2,3,3,3,3,3,2,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,2,2,2,3,2,2,2,2,2,2,2,7,6,6],
      [6,6,7,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,7,6,6],
      [6,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6],
      [6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6],
      [6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6],
    ],
  },
  {
    id: "flowers",
    name: "Kır Çiçekleri",
    colors: {
      3: { name: "Pembe", hex: "#ff8fbf" },
      4: { name: "Mor", hex: "#8b4fd1" },
      8: { name: "Sarı", hex: "#ffd35c" },
      5: { name: "Yeşil", hex: "#4a7c59" },
    },
    grid: [
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,4,0,4,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,4,4,4,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,3,0,3,0,0,0,4,4,8,4,4,0,0,0,3,0,3,0,0,0],
      [0,0,0,3,3,3,0,0,0,4,4,4,4,4,0,0,0,3,3,3,0,0,0],
      [0,0,3,3,8,3,3,0,0,0,0,4,0,0,0,0,3,3,8,3,3,0,0],
      [0,0,3,3,3,3,3,0,0,0,0,5,0,0,0,0,3,3,3,3,3,0,0],
      [0,0,0,0,3,0,0,0,0,0,0,5,0,0,0,0,0,0,3,0,0,0,0],
      [0,0,0,0,5,0,0,0,0,0,5,5,0,0,0,0,0,0,5,0,0,0,0],
      [0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0],
      [0,0,0,5,5,0,0,0,0,0,0,5,5,0,0,0,0,5,5,0,0,0,0],
      [0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0],
      [0,0,0,0,5,5,0,0,0,0,0,5,0,0,0,0,0,0,5,5,0,0,0],
      [0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0],
      [0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0],
      [0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0],
      [0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0,0,0,5,0,0,0,0],
      [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5],
      [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5],
    ],
  },
  {
    id: "text",
    name: "Zezi ❤",
    colors: {
      1: { name: "Pembe", hex: "#ff8fbf" },
      2: { name: "Kırmızı", hex: "#ff4d6d" },
    },
    grid: [
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,0],
      [0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0],
      [0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0],
      [0,0,0,0,1,0,0,0,1,1,1,1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0],
      [0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0],
      [0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0],
      [0,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,2,2,0,2,2,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    ],
  },
];

const levelSelectEl = document.getElementById("levelSelect");
const gameScreenEl = document.getElementById("gameScreen");
const levelGridEl = document.getElementById("levelGrid");
const levelTitleEl = document.getElementById("levelTitle");
const boardEl = document.getElementById("board");
const paletteEl = document.getElementById("palette");
const progressFillEl = document.getElementById("progressFill");
const progressTextEl = document.getElementById("progressText");
const mistakeCountEl = document.getElementById("mistakeCount");
const winOverlayEl = document.getElementById("winOverlay");
const winStatsEl = document.getElementById("winStats");
const resetBtn = document.getElementById("resetBtn");
const playAgainBtn = document.getElementById("playAgainBtn");
const nextLevelBtn = document.getElementById("nextLevelBtn");
const backBtn = document.getElementById("backBtn");

let currentLevelIndex = 0;
let selectedColor = null;
let mistakes = 0;
let filledCount = 0;
let totalCount = 0;

function loadCompleted() {
  try {
    return JSON.parse(localStorage.getItem("kuromi-pixel-completed") || "{}");
  } catch (e) {
    return {};
  }
}

function markCompleted(levelId) {
  try {
    const done = loadCompleted();
    done[levelId] = true;
    localStorage.setItem("kuromi-pixel-completed", JSON.stringify(done));
  } catch (e) {}
}

function buildLevelSelect() {
  const completed = loadCompleted();
  levelGridEl.innerHTML = "";

  LEVELS.forEach((level, index) => {
    const card = document.createElement("button");
    card.type = "button";
    card.className = "level-card";

    const preview = document.createElement("div");
    preview.className = "level-card__preview";
    const cols = level.grid[0].length;
    preview.style.gridTemplateColumns = `repeat(${cols}, 1fr)`;
    level.grid.forEach((row) => {
      row.forEach((value) => {
        const px = document.createElement("span");
        px.style.background = value === 0 ? "transparent" : level.colors[value].hex;
        preview.appendChild(px);
      });
    });

    const name = document.createElement("div");
    name.className = "level-card__name";
    name.textContent = level.name;

    card.appendChild(preview);
    card.appendChild(name);

    if (completed[level.id]) {
      const done = document.createElement("div");
      done.className = "level-card__done";
      done.textContent = "✓ tamamlandı";
      card.appendChild(done);
    }

    card.addEventListener("click", () => openLevel(index));
    levelGridEl.appendChild(card);
  });
}

function openLevel(index) {
  currentLevelIndex = index;
  levelSelectEl.classList.add("hidden");
  gameScreenEl.classList.remove("hidden");
  startLevel();
}

function backToLevels() {
  gameScreenEl.classList.add("hidden");
  levelSelectEl.classList.remove("hidden");
  buildLevelSelect();
}

function currentLevel() {
  return LEVELS[currentLevelIndex];
}

function startLevel() {
  const level = currentLevel();
  levelTitleEl.textContent = level.name;
  selectedColor = null;
  mistakes = 0;
  mistakeCountEl.textContent = "0";
  winOverlayEl.classList.add("hidden");
  buildBoard(level);
  buildPalette(level);
}

function buildBoard(level) {
  const rows = level.grid.length;
  const cols = level.grid[0].length;
  boardEl.style.setProperty("--cols", cols);
  boardEl.style.aspectRatio = `${cols} / ${rows}`;
  boardEl.innerHTML = "";
  totalCount = 0;
  filledCount = 0;

  for (let r = 0; r < rows; r++) {
    for (let c = 0; c < cols; c++) {
      const value = level.grid[r][c];
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
        btn.setAttribute("aria-label", `${level.colors[value].name} kare`);
        btn.addEventListener("click", () => handleCellClick(btn, value));
        totalCount++;
      }

      boardEl.appendChild(btn);
    }
  }

  updateProgress();
}

function buildPalette(level) {
  paletteEl.innerHTML = "";
  Object.entries(level.colors).forEach(([code, info]) => {
    const remaining = countRemaining(level, Number(code));
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

function countRemaining(level, code) {
  let count = 0;
  level.grid.forEach((row) => {
    row.forEach((value) => {
      if (value === code) count++;
    });
  });
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
  btn.style.background = currentLevel().colors[value].hex;
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
  markCompleted(currentLevel().id);
  nextLevelBtn.classList.toggle("hidden", currentLevelIndex >= LEVELS.length - 1);
}

resetBtn.addEventListener("click", startLevel);
playAgainBtn.addEventListener("click", startLevel);
nextLevelBtn.addEventListener("click", () => {
  if (currentLevelIndex < LEVELS.length - 1) {
    openLevel(currentLevelIndex + 1);
  }
});
backBtn.addEventListener("click", backToLevels);

buildLevelSelect();
