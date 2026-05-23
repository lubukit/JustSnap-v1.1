const defaultItems = [
  { id: 1, name: "Iphone 16 Pro Max", bag: "Beg Bagasi", packed: true, image: "assets/images/About us 1-Background-JustSnap.jpg" },
  { id: 2, name: "Passport", bag: "Beg Bagasi", packed: false, image: "assets/images/About us 2-Background-JustSnap.jpg" },
  { id: 3, name: "Cable Phone", bag: "Beg sandang", packed: false, image: "assets/images/About us 3-Background-JustSnap.jpg" },
  { id: 4, name: "Berus gigi", bag: "Beg Bagasi", packed: false, image: "assets/images/About us 1-Background-JustSnap.jpg" },
  { id: 5, name: "Wallet", bag: "Beg Tangan", packed: true, image: "assets/images/About us 2-Background-JustSnap.jpg" }
];

const state = {
  screen: "home",
  bag: "Beg Bagasi",
  items: JSON.parse(localStorage.getItem("justsnap-items") || "null") || defaultItems,
  history: JSON.parse(localStorage.getItem("justsnap-history") || "null") || [
    "Iphone 16 Pro Max stored at bag bagasi",
    "Wallet stored at beg tangan"
  ]
};

const $ = (selector) => document.querySelector(selector);
const $$ = (selector) => [...document.querySelectorAll(selector)];

function save() {
  localStorage.setItem("justsnap-items", JSON.stringify(state.items));
  localStorage.setItem("justsnap-history", JSON.stringify(state.history));
}

function show(screen) {
  state.screen = screen;
  $$(".view").forEach((view) => view.classList.remove("active"));
  $(`#view-${screen}`)?.classList.add("active");
  $$(".nav-item").forEach((button) => button.classList.toggle("active", button.dataset.nav === screen));
  $(".phone-shell").dataset.screen = screen;
  render();
}

function itemRow(item, mode = "status") {
  const statusClass = item.packed ? "status" : "status missing";
  const statusText = item.packed ? "✓" : "!";
  const action = mode === "toggle" ? `data-action="toggle" data-id="${item.id}"` : "";
  return `
    <article class="item">
      <img class="thumb" src="${item.image}" alt="" />
      <div>
        <strong>${item.name}</strong>
        <small>Stored at ${item.bag.toLowerCase()}</small>
      </div>
      <button class="${statusClass}" type="button" ${action}>${statusText}</button>
    </article>
  `;
}

function renderRecent() {
  const items = state.items.filter((item) => item.bag === state.bag);
  $("#recent-list").innerHTML = items.map((item) => itemRow(item)).join("");
}

function renderAlerts() {
  const missing = state.items.filter((item) => !item.packed);
  $("#alert-list").innerHTML = missing.length
    ? missing.map((item) => `
      <article class="alert-card">
        Kami perasan anda belum mengimbas <b>${item.name}</b>.<br />
        Adakah anda lupa membawanya?
        <button type="button" data-action="ok-alert" data-id="${item.id}">OK</button>
      </article>
    `).join("")
    : `<article class="alert-card">Semua barang penting sudah diimbas.<button type="button" data-nav="home">OK</button></article>`;
}

function renderManage() {
  const bags = ["Beg Bagasi", "Beg sandang", "Beg Tangan"];
  $("#manage-bags").innerHTML = bags.map((bag) => {
    const count = state.items.filter((item) => item.bag === bag).length;
    return `
      <article class="bag-card">
        <img src="assets/images/Manage-Icon-JustSnap.png" alt="" />
        <strong>${bag}</strong>
        <span>${count}</span>
      </article>
    `;
  }).join("");
  $("#manage-list").innerHTML = state.items.map((item) => itemRow(item, "toggle")).join("");
}

function renderHistory() {
  $("#history-list").innerHTML = state.history.map((entry, index) => `
    <article class="timeline-row">
      <strong>${entry}</strong>
      <small>${index + 1} minit lalu</small>
    </article>
  `).join("");
}

function renderDetected(items = []) {
  $("#detected-list").innerHTML = items.length
    ? items.map((item) => itemRow(item)).join("")
    : `<article class="timeline-row"><strong>Tekan butang kamera untuk imbas.</strong><small>AI akan cadangkan item dan beg.</small></article>`;
}

function renderStats() {
  const packed = state.items.filter((item) => item.packed).length;
  const missing = state.items.filter((item) => !item.packed).length;
  $("#stat-packed").textContent = packed;
  $("#stat-missing").textContent = missing;
}

function render() {
  renderRecent();
  renderAlerts();
  renderManage();
  renderHistory();
  renderStats();
  renderDetected();
}

function scan() {
  $("#scan-label").textContent = "Scanning...";
  $("#scan-confidence").textContent = "Matching object with travel list";
  setTimeout(() => {
    const found = state.items.slice(0, 3).map((item) => ({ ...item, packed: true }));
    state.items = state.items.map((item) => found.some((foundItem) => foundItem.id === item.id) ? { ...item, packed: true } : item);
    state.history.unshift("AI detected Iphone 16 Pro Max, Power bank and Wallet");
    $("#scan-label").textContent = "Iphone 16 Pro Max";
    $("#scan-confidence").textContent = "98% confidence - Stored at bag bagasi";
    renderDetected(found);
    save();
    renderStats();
  }, 850);
}

function addItem() {
  const name = $("#new-name").value.trim();
  const bag = $("#new-bag").value;
  if (!name) return;
  state.items.unshift({
    id: Date.now(),
    name,
    bag,
    packed: false,
    image: "assets/images/About us 3-Background-JustSnap.jpg"
  });
  state.history.unshift(`${name} added to ${bag}`);
  $("#new-name").value = "";
  $("#add-dialog").close();
  save();
  render();
  show("home");
}

document.addEventListener("click", (event) => {
  const target = event.target.closest("button");
  if (!target) return;

  if (target.dataset.nav) show(target.dataset.nav);
  if (target.dataset.bag) {
    state.bag = target.dataset.bag;
    $$(".pill").forEach((pill) => pill.classList.toggle("active", pill.dataset.bag === state.bag));
    renderRecent();
  }
  if (target.dataset.action === "open-add") $("#add-dialog").showModal();
  if (target.dataset.action === "close-add") $("#add-dialog").close();
  if (target.dataset.action === "save-item") addItem();
  if (target.dataset.action === "scan") scan();
  if (target.dataset.action === "mark-packed") {
    state.items[0].packed = true;
    state.history.unshift(`${state.items[0].name} confirmed`);
    save();
    render();
  }
  if (target.dataset.action === "ok-alert") {
    const id = Number(target.dataset.id);
    state.items = state.items.map((item) => item.id === id ? { ...item, packed: true } : item);
    state.history.unshift("Alert checked");
    save();
    render();
  }
  if (target.dataset.action === "toggle") {
    const id = Number(target.dataset.id);
    state.items = state.items.map((item) => item.id === id ? { ...item, packed: !item.packed } : item);
    save();
    render();
  }
});

render();
