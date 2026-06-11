/* ======================================
   TERRITORY GO - APPLICATION LOGIC
   ====================================== */

// --- State ---
const state = {
  currentScreen: 'splash-screen',
  playerXP: 1250,
  streakCount: 5,
  level: 4,
  rewardPoints: 4250,
  challenges: [
    { title: 'Walk 5km', progress: 3.2, target: 5, xp: 200, icon: 'fa-walking' },
    { title: 'Capture 3 Zones', progress: 1, target: 3, xp: 350, icon: 'fa-flag' },
    { title: 'Run at 10km/h for 5 min', progress: 0, target: 1, xp: 500, icon: 'fa-running' },
  ],
  rewards: [
    { name: 'Territory Go Water Bottle', icon: 'fa-bottle-water', points: 5000, color: '#42A5F5', bg: 'rgba(66,165,245,0.1)' },
    { name: 'Megabyte T-Shirt', icon: 'fa-shirt', points: 12000, color: '#6200EA', bg: 'rgba(98,0,234,0.1)' },
    { name: 'Premium Wireless Headphones', icon: 'fa-headphones', points: 25000, color: '#FF6D00', bg: 'rgba(255,109,0,0.1)' },
    { name: 'Gym Duffle Bag', icon: 'fa-bag-shopping', points: 18000, color: '#00C853', bg: 'rgba(0,200,83,0.1)' },
    { name: '500 Bonus XP', icon: 'fa-star', points: 1000, color: '#FFD700', bg: 'rgba(255,215,0,0.1)' },
  ],
  guildRankings: [
    { name: 'Shadow Legion', members: 48, points: 12400 },
    { name: 'Alpha Strike', members: 35, points: 10800 },
    { name: 'Crimson Wolves', members: 52, points: 9600 },
    { name: 'Iron Vanguard', members: 29, points: 8200 },
    { name: 'Phantom Corp', members: 41, points: 7500 },
    { name: 'Storm Riders', members: 38, points: 6900 },
    { name: 'Apex Predators', members: 22, points: 6100 },
    { name: 'Neon Knights', members: 33, points: 5400 },
  ],
  dailyPlayers: [
    { name: 'TerraRunner', zones: 38, xp: 6200 },
    { name: 'GhostPace', zones: 34, xp: 5800 },
    { name: 'MapQuest99', zones: 30, xp: 5100 },
    { name: 'ZoneHunter', zones: 27, xp: 4600 },
    { name: 'StreetKing', zones: 25, xp: 4200 },
    { name: 'RunDevil', zones: 22, xp: 3800 },
    { name: 'TurboWalker', zones: 20, xp: 3400 },
  ],
  monthlyPlayers: [
    { name: 'BlazePath', zones: 180, xp: 32000 },
    { name: 'GridLord', zones: 165, xp: 28500 },
    { name: 'SpeedCapture', zones: 150, xp: 25100 },
    { name: 'NightOwl', zones: 140, xp: 22000 },
    { name: 'TrailBoss', zones: 130, xp: 19500 },
    { name: 'ZoneMaster', zones: 120, xp: 17200 },
    { name: 'WalkingStar', zones: 110, xp: 15000 },
  ],
};

// --- Screen Navigation ---
function navigateTo(screenId) {
  const screens = document.querySelectorAll('.screen');
  screens.forEach(s => s.classList.remove('active'));
  const target = document.getElementById(screenId);
  if (target) target.classList.add('active');

  state.currentScreen = screenId;

  // Show/hide bottom nav
  const nav = document.getElementById('bottom-nav');
  const screensWithNav = ['home-screen', 'map-screen', 'guild-screen', 'leaderboard-screen', 'profile-screen'];
  if (screensWithNav.includes(screenId)) {
    nav.classList.remove('hidden');
  } else {
    nav.classList.add('hidden');
  }

  // Update active nav button
  document.querySelectorAll('.nav-btn').forEach(btn => {
    btn.classList.toggle('active', btn.dataset.screen === screenId);
  });

  // Initialize map if navigating to map screen
  if (screenId === 'map-screen') {
    setTimeout(() => initMap(), 100);
  }
}

// --- Splash Screen Auto-advance ---
function initSplash() {
  setTimeout(() => {
    navigateTo('login-screen');
  }, 3000);
}

// --- Login ---
function initLogin() {
  const form = document.getElementById('login-form');
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    showToast('Welcome back, Commander! \uD83D\uDD25', 'fa-check-circle');
    setTimeout(() => navigateTo('home-screen'), 800);
  });
}

// --- Populate Challenges ---
function renderChallenges() {
  const container = document.getElementById('challenges-list');
  if (!container) return;
  container.innerHTML = state.challenges.map(c => {
    const pct = Math.min((c.progress / c.target) * 100, 100);
    const colorClass = pct >= 100 ? 'green' : 'orange';
    return `
      <div class="challenge-card">
        <div class="challenge-card-header">
          <span><i class="fas ${c.icon}" style="margin-right:8px;color:var(--text-light)"></i>${c.title}</span>
          <span class="challenge-xp">+${c.xp} XP</span>
        </div>
        <div class="challenge-progress-bar">
          <div class="challenge-progress-fill ${colorClass}" style="width:${pct}%"></div>
        </div>
        <span class="challenge-progress-text">${c.progress} / ${c.target}</span>
      </div>
    `;
  }).join('');
}

// --- Guild Rankings ---
function renderGuildRankings() {
  const container = document.getElementById('guild-rankings-list');
  if (!container) return;
  container.innerHTML = state.guildRankings.map((g, i) => {
    const rankClass = i < 3 ? `guild-rank-${i + 1}` : 'guild-rank-default';
    return `
      <div class="guild-ranking-item">
        <div class="guild-rank ${rankClass}">${i + 1}</div>
        <div class="guild-ranking-info">
          <strong>${g.name}</strong>
          <span>${g.members} members</span>
        </div>
        <span class="guild-ranking-pts">${g.points.toLocaleString()} pts</span>
      </div>
    `;
  }).join('');
}

// --- Leaderboard Lists ---
function renderLeaderboards() {
  renderLeaderboardList('lb-daily-list', state.dailyPlayers);
  renderLeaderboardList('lb-monthly-list', state.monthlyPlayers);
}

function renderLeaderboardList(containerId, players) {
  const container = document.getElementById(containerId);
  if (!container) return;
  const seeds = ['Oliver', 'Mia', 'Leo', 'Ava', 'Noah', 'Emma', 'Liam'];
  container.innerHTML = players.map((p, i) => `
    <div class="lb-item">
      <span class="lb-rank">${i + 4}</span>
      <div class="lb-avatar">
        <img src="https://api.dicebear.com/7.x/adventurer/svg?seed=${seeds[i % seeds.length]}" alt="${p.name}">
      </div>
      <div class="lb-info">
        <strong>${p.name}</strong>
        <span>${p.zones} zones captured</span>
      </div>
      <span class="lb-xp">${p.xp.toLocaleString()} XP</span>
    </div>
  `).join('');
}

// --- Rewards ---
function renderRewards() {
  const container = document.getElementById('rewards-list');
  if (!container) return;
  container.innerHTML = state.rewards.map(r => {
    const canRedeem = state.rewardPoints >= r.points;
    return `
      <div class="reward-card">
        <div class="reward-icon-box" style="background:${r.bg};color:${r.color}">
          <i class="fas ${r.icon}"></i>
        </div>
        <div class="reward-info">
          <strong>${r.name}</strong>
          <span>${r.points.toLocaleString()} Points</span>
        </div>
        <button class="btn-redeem ${canRedeem ? 'available' : 'locked'}">${canRedeem ? 'Redeem' : 'Locked'}</button>
      </div>
    `;
  }).join('');
}

/// --- Map ---
let mapInstance = null;
let playerMarker = null;
let watchId = null;

function initMap() {
  if (mapInstance) {
    mapInstance.invalidateSize();
    return;
  }
  const container = document.getElementById('map-container');
  if (!container) return;

  // Initial dummy view
  mapInstance = L.map(container, {
    zoomControl: false,
  }).setView([37.7749, -122.4194], 14);

  L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
    attribution: '© OpenStreetMap',
    subdomains: 'abcd',
    maxZoom: 19,
  }).addTo(mapInstance);

  const playerIcon = L.divIcon({
    html: '<div style="width:20px;height:20px;background:#00E676;border:3px solid white;border-radius:50%;box-shadow:0 0 12px rgba(0,230,118,0.6)"></div>',
    iconSize: [20, 20],
    className: '',
  });

  playerMarker = L.marker([37.7749, -122.4194], { icon: playerIcon }).addTo(mapInstance)
    .bindPopup('<strong>You are here</strong>');

  // Request GPS
  if ("geolocation" in navigator) {
    watchId = navigator.geolocation.watchPosition(
      (position) => {
        const lat = position.coords.latitude;
        const lng = position.coords.longitude;
        
        // Update marker and map center
        playerMarker.setLatLng([lat, lng]);
        mapInstance.setView([lat, lng], 15);
        
        // Draw zones relative to user's first location if not drawn
        if (!mapInstance.zonesDrawn) {
          drawDynamicZones(lat, lng);
          mapInstance.zonesDrawn = true;
        }
      },
      (error) => {
        console.warn("GPS Error: ", error);
        showToast("Please allow location access to play", "fa-exclamation-triangle");
      },
      { enableHighAccuracy: true, maximumAge: 10000, timeout: 5000 }
    );
  } else {
    showToast("GPS not supported on your device", "fa-exclamation-triangle");
  }
}

function drawDynamicZones(lat, lng) {
  const offset = 0.005; // rough degree offset for demo zones

  // Safe zone (green) - slightly North
  L.polygon([
    [lat + offset, lng - offset],
    [lat + offset*2, lng - offset],
    [lat + offset*2, lng + offset],
    [lat + offset, lng + offset],
  ], { color: '#00C853', fillColor: '#00C853', fillOpacity: 0.35, weight: 2 }).addTo(mapInstance)
    .bindPopup('<strong>Safe Zone</strong><br>Local Area');

  // Danger zone (red) - slightly South
  L.polygon([
    [lat - offset*2, lng - offset],
    [lat - offset, lng - offset],
    [lat - offset, lng + offset],
    [lat - offset*2, lng + offset],
  ], { color: '#D50000', fillColor: '#D50000', fillOpacity: 0.35, weight: 2 }).addTo(mapInstance)
    .bindPopup('<strong>⚠️ Danger Zone</strong><br>High-risk territory');

  // Private zone (purple) - slightly East
  L.polygon([
    [lat - offset, lng + offset*1.5],
    [lat + offset, lng + offset*1.5],
    [lat + offset, lng + offset*2.5],
    [lat - offset, lng + offset*2.5],
  ], { color: '#6200EA', fillColor: '#6200EA', fillOpacity: 0.35, weight: 2 }).addTo(mapInstance)
    .bindPopup('<strong>🔒 Private Zone</strong><br>Locked territory');

  // Neutral zone (blue) - slightly West
  L.polygon([
    [lat - offset, lng - offset*2.5],
    [lat + offset, lng - offset*2.5],
    [lat + offset, lng - offset*1.5],
    [lat - offset, lng - offset*1.5],
  ], { color: '#42A5F5', fillColor: '#42A5F5', fillOpacity: 0.35, weight: 2 }).addTo(mapInstance)
    .bindPopup('<strong>Neutral Zone</strong><br>Unclaimed territory');
}

function toggleMapLegend() {
  const legend = document.getElementById('map-legend');
  legend.classList.toggle('hidden');
}

// --- Capture Zone ---
function initCaptureButton() {
  const btn = document.getElementById('capture-btn');
  if (btn) {
    btn.addEventListener('click', () => {
      showToast('Zone captured! +200 XP \uD83C\uDFF4', 'fa-flag');
      state.playerXP += 200;
      updatePlayerStats();
    });
  }
}

function updatePlayerStats() {
  const xpEl = document.getElementById('player-xp');
  if (xpEl) xpEl.textContent = state.playerXP.toLocaleString();
}

// --- Tabs ---
function initTabs() {
  document.querySelectorAll('.tab-bar').forEach(bar => {
    bar.querySelectorAll('.tab-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        const tabId = btn.dataset.tab;
        bar.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const parent = bar.nextElementSibling;
        if (parent) {
          parent.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
          const targetPane = document.getElementById(tabId);
          if (targetPane) targetPane.classList.add('active');
        }
      });
    });
  });
}

// --- Bottom Navigation ---
function initBottomNav() {
  document.querySelectorAll('.nav-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const screen = btn.dataset.screen;
      if (screen) navigateTo(screen);
    });
  });
}

// --- Toast Notification ---
function showToast(message, icon) {
  let toast = document.querySelector('.toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.className = 'toast';
    document.body.appendChild(toast);
  }
  toast.innerHTML = `<i class="fas ${icon || 'fa-check-circle'}"></i> ${message}`;
  requestAnimationFrame(() => {
    toast.classList.add('visible');
    setTimeout(() => {
      toast.classList.remove('visible');
    }, 2500);
  });
}

// --- Chat ---
function initChat() {
  const input = document.querySelector('.chat-input');
  const sendBtn = document.querySelector('.btn-send');
  if (!input || !sendBtn) return;

  const sendMessage = () => {
    const text = input.value.trim();
    if (!text) return;
    const messages = document.getElementById('chat-messages');
    const now = new Date();
    const time = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    messages.innerHTML += `
      <div class="chat-msg chat-msg-self">
        <div class="chat-bubble">
          <p>${text}</p>
          <span class="chat-time">${time}</span>
        </div>
      </div>
    `;
    input.value = '';
    messages.scrollTop = messages.scrollHeight;
  };

  sendBtn.addEventListener('click', sendMessage);
  input.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') sendMessage();
  });
}

// --- Initialize App ---
document.addEventListener('DOMContentLoaded', () => {
  initSplash();
  initLogin();
  renderChallenges();
  renderGuildRankings();
  renderLeaderboards();
  renderRewards();
  initTabs();
  initBottomNav();
  initCaptureButton();
  initChat();
});
