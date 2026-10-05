// config.js

// ── Type ──────────────────────────────────────────────────────────
var font = "JetBrainsMono Nerd"

// ── Shared layout metrics (used by many widgets) ──────────────────
var dims = {
	radius: 10,
	radiusSmall: 8,
	border: 2,    // thin (panels)
	borderThick: 4,    // thick (notification cards)

	margin: 10,    // padding inside cards
	marginLarge: 12,    // padding inside panels
	spacing: 10,
	spacingSmall: 8,
	spacingTiny: 2,

	iconSize: 36,

	fontSizeSmall: 10,
	fontSizeSubtitle: 12,
	fontSize: 14,
	fontSizeTitle: 18,
	fontSizeLarge: 20,
}

// ── Shared palette (widgets can override) ─────────────────────────
var generic = {
	card: "#2f2f2f",
	transparent: "transparent",
	text: "white",
	title: "cyan",
	accent: "red",     // active workspace + "Clear all"
	muted: "gray",    // inactive workspaces
}

// ── Per-widget settings ───────────────────────────────────────────
var top = {
	height: 24,
	width: 320,
	color: "#3f3f3f",
	radius: 8,          // <— new; corners of the floating bar

}

var tray = {
	height: 32,
	color: "#0f0f0f",
	spacing: 8,
	icons: { width: 32, height: 32 },
}

var clock = {
	format: "hh:mm | yyyy/MM/dd",
	fontSize: dims.fontSizeLarge,
}

var volume = {
	fontSize: dims.fontSizeLarge,
	step: 0.02,          // 2% per wheel tick
	minMove: 30
}

var workspaces = {
	active: "red",
	inactive: "gray",
	count: 10,
	spacing: 8,
}

var battery = {
	low: "#af0000",
	normal: "white",
	charging: "#00ff00",
	critical: 30,            // percent
	fontSize: dims.fontSizeLarge,
}

var notifs = {
	// colors
	border: "#0a55ff",
	borderCritical: "red",

	// timing
	timeout: 5000,

	// live popups (top-right corner)
	popupWidth: 380,
	popupMargin: 12,        // from screen edge

	// history panel (opened from the counter)
	panelWidth: 380,
	panelMaxHeight: 600,
	panelScreenMargin: 25,   // from screen edge
}