import { useState, useEffect, useRef, useCallback } from "react";

const FONTS = [
  { family: "'Playfair Display', serif", weight: "700" },
  { family: "'Cormorant Garamond', serif", weight: "300" },
  { family: "'DM Serif Display', serif", weight: "400" },
  { family: "'Bodoni Moda', serif", weight: "400" },
  { family: "'Raleway', sans-serif", weight: "200" },
  { family: "'Josefin Sans', sans-serif", weight: "300" },
  { family: "'Caveat', cursive", weight: "400" },
  { family: "'Space Mono', monospace", weight: "400" },
  { family: "'Italiana', serif", weight: "400" },
  { family: "'Poiret One', sans-serif", weight: "400" },
  { family: "'Spectral', serif", weight: "300" },
  { family: "'Unbounded', sans-serif", weight: "300" },
];

const PALETTES = [
  { text: "#e8d5b7", glow: "rgba(232,213,183,0.10)" },
  { text: "#7eb8d4", glow: "rgba(126,184,212,0.10)" },
  { text: "#d4a07e", glow: "rgba(212,160,126,0.10)" },
  { text: "#8cc4a0", glow: "rgba(140,196,160,0.10)" },
  { text: "#d48a8a", glow: "rgba(212,138,138,0.10)" },
  { text: "#f5f0e8", glow: "rgba(245,240,232,0.08)" },
  { text: "#b89cd4", glow: "rgba(184,156,212,0.10)" },
  { text: "#d4c870", glow: "rgba(212,200,112,0.10)" },
  { text: "#e0b0c0", glow: "rgba(224,176,192,0.10)" },
  { text: "#90c8c8", glow: "rgba(144,200,200,0.10)" },
];

const SIZES = [18, 22, 26, 32, 40, 50];

const DEFAULT_POEMS = [
  "Byl pozdní večer, první máj,\nvečerní máj, byl lásky čas.\nHrdliččin zval ku lásce hlas,\nkde borový zaváněl háj.",
  "Kdo v zlaté struny zahrát zná,\nten ztracen jest i jiným světům;\nneb hudba jest ta rajská brána,\nkudy se vchází nebem k květům.",
  "Nad vodou strom se vážně kloní,\na v trávě leží tichý stín.\nKdes ve tmě slavík zpívá, zvoní,\njak flétna z hvězdných dálek, klín.",
  "Ticho je v lese, ticho všude,\njak v kostele, když kněz se modlí.\nJen potok šumí, šepce, bude\nsi hrát, než zima přijde podlí.",
  "Podzimní listí padá tiše,\nzlacené stopy na zemi.\nVítr si šeptá, nikdo slyší,\njak čas se ztrácí s okamžiky.",
  "Měsíc se dívá přes okno,\nstříbrné světlo na podlaze.\nVšechno je tiché, všechno pokojno,\njak sen, co nikdo nevymaže.",
  "Ráno se budí, rosa třpytí,\nna stéblech trávy diamanty.\nSvět je tak krásný, stojí za žití,\nkdyž slunce zlacuje ty instranty.",
  "V dálce se modrá hora zvedá,\noblaka tančí na obzoru.\nDuše má touží, srdce hledá\ncestu zpět k dávnému hovoru.",
];

function pick(arr) { return arr[Math.floor(Math.random() * arr.length)]; }

function splitIntoStanzas(text) {
  return text.split(/\n\n+/).map(s => s.trim()).filter(s => s.length > 0);
}

function UploadPanel({ onUpload, isOpen, onToggle, poemCount }) {
  const fileInputRef = useRef(null);
  const [dragOver, setDragOver] = useState(false);

  const handleFiles = useCallback((files) => {
    Array.from(files).forEach(file => {
      if (file.type === "text/plain" || file.name.endsWith(".txt")) {
        const reader = new FileReader();
        reader.onload = e => onUpload(e.target.result);
        reader.readAsText(file);
      }
    });
  }, [onUpload]);

  return (
    <>
      <button
        onClick={onToggle}
        style={{
          position: "fixed", bottom: 28, right: 28, zIndex: 1000,
          background: isOpen ? "rgba(255,255,255,0.12)" : "rgba(255,255,255,0.06)",
          border: "1px solid rgba(255,255,255,0.15)", borderRadius: "50%",
          width: 52, height: 52, cursor: "pointer",
          display: "flex", alignItems: "center", justifyContent: "center",
          backdropFilter: "blur(12px)", transition: "all 0.4s ease",
          color: "#d4c8b8", fontSize: 24, fontWeight: 300,
        }}
      >
        {isOpen ? "×" : "+"}
      </button>

      {isOpen && (
        <div style={{
          position: "fixed", bottom: 92, right: 28, zIndex: 999,
          background: "rgba(12,10,8,0.94)", border: "1px solid rgba(255,255,255,0.1)",
          borderRadius: 16, padding: 24, width: 320, maxWidth: "calc(100vw - 56px)",
          backdropFilter: "blur(24px)", animation: "slideUp 0.3s ease",
        }}>
          <h3 style={{
            margin: "0 0 4px", color: "#e8d5b7",
            fontFamily: "'Cormorant Garamond', serif", fontSize: 22,
            fontWeight: 400, letterSpacing: 0.5,
          }}>Nahrát básně</h3>
          <p style={{ margin: "0 0 18px", color: "rgba(255,255,255,0.35)", fontSize: 13, fontFamily: "'Spectral', serif" }}>
            {poemCount} strof ve streamu
          </p>

          <div
            onDragOver={e => { e.preventDefault(); setDragOver(true); }}
            onDragLeave={() => setDragOver(false)}
            onDrop={e => { e.preventDefault(); setDragOver(false); handleFiles(e.dataTransfer.files); }}
            onClick={() => fileInputRef.current?.click()}
            style={{
              border: `1.5px dashed ${dragOver ? "rgba(232,213,183,0.5)" : "rgba(255,255,255,0.12)"}`,
              borderRadius: 12, padding: "24px 16px", textAlign: "center", cursor: "pointer",
              transition: "all 0.3s ease",
              background: dragOver ? "rgba(232,213,183,0.04)" : "transparent",
            }}
          >
            <div style={{ fontSize: 28, marginBottom: 8, opacity: 0.5 }}>📜</div>
            <div style={{ color: "rgba(255,255,255,0.45)", fontSize: 14, fontFamily: "'Spectral', serif", lineHeight: 1.6 }}>
              Přetáhněte .txt soubory<br />
              <span style={{ fontSize: 12, opacity: 0.6 }}>nebo klikněte pro výběr</span>
            </div>
          </div>

          <input ref={fileInputRef} type="file" accept=".txt,text/plain" multiple
            onChange={e => { handleFiles(e.target.files); e.target.value = ""; }}
            style={{ display: "none" }} />

          <textarea
            placeholder="...nebo vložte text básně přímo sem"
            style={{
              width: "100%", marginTop: 12, padding: 14,
              background: "rgba(255,255,255,0.04)", border: "1px solid rgba(255,255,255,0.08)",
              borderRadius: 10, color: "#d4c8b8", fontFamily: "'Spectral', serif",
              fontSize: 14, resize: "vertical", minHeight: 80, outline: "none",
              boxSizing: "border-box", lineHeight: 1.6,
            }}
            onKeyDown={e => {
              if (e.key === "Enter" && (e.metaKey || e.ctrlKey)) {
                onUpload(e.target.value); e.target.value = "";
              }
            }}
          />
          <p style={{ margin: "6px 0 0", color: "rgba(255,255,255,0.2)", fontSize: 11, fontFamily: "'Spectral', serif" }}>
            Ctrl+Enter pro přidání do streamu
          </p>
        </div>
      )}
    </>
  );
}

export default function PoetryStream() {
  const [verse, setVerse] = useState(null);
  const [visible, setVisible] = useState(false);
  const [tick, setTick] = useState(0);
  const [isPlaying, setIsPlaying] = useState(true);
  const [panelOpen, setPanelOpen] = useState(false);
  const [allStanzas, setAllStanzas] = useState(() => {
    const out = [];
    DEFAULT_POEMS.forEach(p => out.push(...splitIntoStanzas(p)));
    return out;
  });

  const shuffledRef = useRef([]);
  const indexRef = useRef(0);

  const nextVerse = useCallback(() => {
    if (allStanzas.length === 0) return null;
    if (!shuffledRef.current.length || indexRef.current >= shuffledRef.current.length) {
      shuffledRef.current = [...allStanzas].sort(() => Math.random() - 0.5);
      indexRef.current = 0;
    }
    const text = shuffledRef.current[indexRef.current++];
    return { text, font: pick(FONTS), size: pick(SIZES), palette: pick(PALETTES), italic: Math.random() > 0.7 };
  }, [allStanzas]);

  // Single cycle effect
  useEffect(() => {
    if (!isPlaying) return;
    const v = nextVerse();
    if (!v) return;

    setVerse(v);
    setVisible(false);

    const t1 = setTimeout(() => setVisible(true), 120);
    const t2 = setTimeout(() => setVisible(false), 8000);
    const t3 = setTimeout(() => setTick(t => t + 1), 11500);

    return () => { clearTimeout(t1); clearTimeout(t2); clearTimeout(t3); };
  }, [tick, isPlaying, nextVerse]);

  const handleUpload = useCallback(text => {
    const s = splitIntoStanzas(text).filter(s => s.length > 0);
    if (s.length) {
      setAllStanzas(prev => [...prev, ...s]);
      shuffledRef.current = [];
      indexRef.current = 0;
    }
  }, []);

  return (
    <div style={{ position: "fixed", inset: 0, background: "#080604", overflow: "hidden", display: "flex", alignItems: "center", justifyContent: "center" }}>
      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Cormorant+Garamond:ital,wght@0,300;0,400;1,300;1,400&family=DM+Serif+Display:ital@0;1&family=Bodoni+Moda:ital,wght@0,400;1,400&family=Raleway:ital,wght@0,200;0,300;1,200&family=Josefin+Sans:ital,wght@0,300;0,400;1,300&family=Caveat:wght@400;500&family=Space+Mono:ital@0;1&family=Italiana&family=Poiret+One&family=Spectral:ital,wght@0,300;0,400;1,300&family=Unbounded:wght@300;400&display=swap');
        @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.3} }
        @keyframes slideUp { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
        @keyframes bgPulse {
          0%,100% { background: radial-gradient(ellipse at 30% 50%,rgba(25,18,10,0.9) 0%,transparent 70%), radial-gradient(ellipse at 70% 30%,rgba(12,20,28,0.6) 0%,transparent 60%), #080604; }
          50% { background: radial-gradient(ellipse at 60% 40%,rgba(25,18,10,0.9) 0%,transparent 70%), radial-gradient(ellipse at 30% 70%,rgba(12,20,28,0.6) 0%,transparent 60%), #080604; }
        }
        *{-webkit-tap-highlight-color:transparent} ::selection{background:rgba(232,213,183,0.15)}
      `}</style>

      <div style={{ position: "absolute", inset: 0, animation: "bgPulse 40s ease infinite" }} />
      <div style={{ position: "absolute", inset: 0, opacity: 0.025, background: "url(\"data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E\")", pointerEvents: "none" }} />

      {/* Verse */}
      {verse && (
        <div
          key={tick}
          style={{
            position: "relative", zIndex: 10,
            maxWidth: "min(85vw, 720px)", padding: "0 32px",
            textAlign: "center",
            opacity: visible ? 1 : 0,
            transition: "opacity 2.8s ease-in-out",
            fontFamily: verse.font.family,
            fontSize: `clamp(18px, ${verse.size / 10}vw + 6px, ${verse.size + 10}px)`,
            color: verse.palette.text,
            fontStyle: verse.italic ? "italic" : "normal",
            fontWeight: verse.font.weight, lineHeight: 1.9, letterSpacing: "0.025em",
            whiteSpace: "pre-line",
            textShadow: `0 0 80px ${verse.palette.glow}, 0 0 160px ${verse.palette.glow}`,
          }}
        >
          {verse.text}
        </div>
      )}

      {/* Play/pause */}
      <div style={{ position: "fixed", top: 24, left: 24, zIndex: 1000 }}>
        <button
          onClick={() => { setIsPlaying(p => !p); if (!isPlaying) setTick(t => t + 1); }}
          style={{
            background: "rgba(255,255,255,0.05)", border: "1px solid rgba(255,255,255,0.08)",
            borderRadius: 10, padding: "8px 16px", cursor: "pointer",
            color: "rgba(255,255,255,0.4)", fontFamily: "'Cormorant Garamond', serif",
            fontSize: 14, letterSpacing: 2, backdropFilter: "blur(12px)",
            transition: "all 0.3s ease", display: "flex", alignItems: "center", gap: 10,
          }}
        >
          <span style={{
            width: 7, height: 7, borderRadius: "50%",
            background: isPlaying ? "#a8c4d4" : "rgba(255,255,255,0.25)",
            boxShadow: isPlaying ? "0 0 10px rgba(168,196,212,0.4)" : "none",
            animation: isPlaying ? "pulse 2.5s ease infinite" : "none",
          }} />
          {isPlaying ? "ŽIVĚ" : "PAUZA"}
        </button>
      </div>

      <UploadPanel onUpload={handleUpload} isOpen={panelOpen} onToggle={() => setPanelOpen(p => !p)} poemCount={allStanzas.length} />

      <div style={{ position: "fixed", bottom: 28, left: 28, zIndex: 100, color: "rgba(255,255,255,0.15)", fontFamily: "'Spectral', serif", fontSize: 12, letterSpacing: 0.5 }}>
        {allStanzas.length} strof · nekonečný stream
      </div>
    </div>
  );
}
