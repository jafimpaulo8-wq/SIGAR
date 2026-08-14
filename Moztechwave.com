<!DOCTYPE html>
<html lang="pt">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#0B0F1A">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="description" content="SIGAR Académico — CFTPM Moztechwave">
<title>SIGAR Académico · Moztechwave</title>
<link rel="manifest" href="data:application/json,{"name":"SIGAR Académico","short_name":"SIGAR","start_url":"./menu.html","display":"standalone","background_color":"#0B0F1A","theme_color":"#0B0F1A"}">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
:root{
  --bg:#0B0F1A;
  --card:#141B2D;
  --card2:#1A2338;
  --border:rgba(255,255,255,.08);
  --text:#F1F5F9;
  --muted:#94A3B8;
  --gold:#C9A02A;
  --blue:#3B82F6;
  --green:#22C55E;
  --purple:#A78BFA;
  --orange:#F59E0B;
  --cyan:#22D3EE;
}
*{box-sizing:border-box;margin:0;padding:0}
body{
  font-family:Inter,system-ui,sans-serif;
  background:var(--bg);
  color:var(--text);
  min-height:100vh;
  padding:0 0 88px;
  -webkit-tap-highlight-color:transparent;
}
.top{
  padding:18px 16px 12px;
  display:flex;align-items:center;justify-content:space-between;
  position:sticky;top:0;z-index:20;
  background:linear-gradient(180deg,#0B0F1A 70%,transparent);
  backdrop-filter:blur(8px);
}
.brand{display:flex;align-items:center;gap:10px}
.avatar{
  width:40px;height:40px;border-radius:12px;
  background:linear-gradient(135deg,#1B3A6B,var(--gold));
  display:flex;align-items:center;justify-content:center;
  font-weight:800;font-size:13px;color:#fff;
}
.brand h1{font-size:15px;font-weight:700;line-height:1.2}
.brand span{font-size:11px;color:var(--green);display:flex;align-items:center;gap:5px}
.brand span::before{content:'';width:7px;height:7px;border-radius:50%;background:var(--green);box-shadow:0 0 8px var(--green)}
.bell{
  width:36px;height:36px;border-radius:10px;background:var(--card);
  border:1px solid var(--border);display:flex;align-items:center;justify-content:center;
  font-size:16px;color:var(--muted);
}

.stats{
  margin:4px 16px 16px;
  background:linear-gradient(135deg,#1E293B,#0F172A);
  border:1px solid var(--border);
  border-radius:16px;padding:14px 16px;
  display:grid;grid-template-columns:1fr 1fr;gap:12px;
}
.stats .lbl{font-size:10px;color:var(--muted);font-weight:600;letter-spacing:.5px;text-transform:uppercase}
.stats .val{font-size:18px;font-weight:800;margin-top:4px}
.stats .val.gold{color:var(--gold)}

.sec{padding:0 16px;margin-bottom:8px}
.sec-title{font-size:13px;font-weight:700;color:var(--muted);margin-bottom:10px}

.grid{
  display:grid;grid-template-columns:1fr 1fr;gap:10px;
  padding:0 16px 14px;
}
.tile{
  background:var(--card);
  border:1px solid var(--border);
  border-radius:16px;padding:14px;
  text-decoration:none;color:inherit;
  display:flex;flex-direction:column;gap:8px;
  transition:.15s;min-height:110px;
}
.tile:active{transform:scale(.97);background:var(--card2)}
.tile .ico{
  width:36px;height:36px;border-radius:11px;
  display:flex;align-items:center;justify-content:center;font-size:18px;
}
.tile h3{font-size:13px;font-weight:700}
.tile p{font-size:11px;color:var(--muted);line-height:1.35}

.list{padding:0 16px 16px;display:flex;flex-direction:column;gap:10px}
.row{
  background:var(--card);
  border:1px solid var(--border);
  border-radius:16px;padding:14px;
  display:flex;align-items:center;gap:12px;
  text-decoration:none;color:inherit;
}
.row:active{background:var(--card2)}
.row .ico{
  width:42px;height:42px;border-radius:12px;
  display:flex;align-items:center;justify-content:center;font-size:18px;flex-shrink:0;
}
.row .body{flex:1;min-width:0}
.row h3{font-size:13.5px;font-weight:700}
.row p{font-size:11px;color:var(--muted);margin-top:2px;line-height:1.35}
.badge{
  font-size:9px;font-weight:700;padding:3px 8px;border-radius:99px;
  display:inline-block;margin-bottom:4px;letter-spacing:.3px;
}
.row .go{color:var(--muted);font-size:18px}
.live{font-size:10px;color:var(--green);margin-top:4px}

.search{
  margin:0 16px 16px;
  background:var(--card);
  border:1px solid var(--border);
  border-radius:12px;padding:11px 14px;
  display:flex;align-items:center;gap:8px;
}
.search input{
  flex:1;background:transparent;border:none;outline:none;
  color:var(--text);font-size:13px;font-family:inherit;
}
.search input::placeholder{color:var(--muted)}

.nav{
  position:fixed;bottom:0;left:0;right:0;
  background:#0E1424;border-top:1px solid var(--border);
  display:flex;justify-content:space-around;padding:8px 6px calc(8px + env(safe-area-inset-bottom));
  z-index:30;
}
.nav a{
  text-decoration:none;color:var(--muted);font-size:10px;font-weight:600;
  display:flex;flex-direction:column;align-items:center;gap:3px;padding:4px 10px;
}
.nav a.on{color:var(--purple)}
.nav .ni{font-size:18px}

.hint{
  margin:0 16px 20px;padding:12px 14px;
  background:rgba(201,160,42,.1);border:1px solid rgba(201,160,42,.25);
  border-radius:12px;font-size:11.5px;color:#E8D080;line-height:1.45;
}

.c-blue{background:rgba(59,130,246,.15);color:#60A5FA}
.c-gold{background:rgba(201,160,42,.15);color:var(--gold)}
.c-green{background:rgba(34,197,94,.15);color:#4ADE80}
.c-purple{background:rgba(167,139,250,.15);color:var(--purple)}
.c-orange{background:rgba(245,158,11,.15);color:var(--orange)}
.c-cyan{background:rgba(34,211,238,.15);color:var(--cyan)}
.c-pink{background:rgba(244,114,182,.15);color:#F9A8D4}

@media(min-width:520px){
  body{max-width:430px;margin:0 auto;border-left:1px solid var(--border);border-right:1px solid var(--border)}
}
</style>
</head>
<body>

<header class="top">
  <div class="brand">
    <div class="avatar">AD</div>
    <div>
      <h1>SIGAR Académico</h1>
      <span>Firebase Ligado</span>
    </div>
  </div>
  <div class="bell">🔔</div>
</header>

<section class="stats">
  <div>
    <div class="lbl">Instituição</div>
    <div class="val gold">CFTPM</div>
  </div>
  <div>
    <div class="lbl">Sistema</div>
    <div class="val">SIGAR</div>
  </div>
</section>

<p class="sec sec-title">Painéis Académicos</p>
<div class="grid">
  <a class="tile" href="https://sigar-nine.vercel.app/sigar_admin_firebase.html">
    <div class="ico c-blue">🔐</div>
    <h3>Painel Diretor</h3>
    <p>Gestão administrativa</p>
  </a>
  <a class="tile" href="https://sigar-nine.vercel.app/sigar_professor.html">
    <div class="ico c-green">👤</div>
    <h3>Professor</h3>
    <p>Diário de classe</p>
  </a>
  <a class="tile" href="https://sigar-nine.vercel.app/">
    <div class="ico c-gold">🎓</div>
    <h3>Inscrições</h3>
    <p>Portal público</p>
  </a>
  <a class="tile" href="https://sigar-nine.vercel.app/verificar-1.html">
    <div class="ico c-purple">✅</div>
    <h3>Certificados</h3>
    <p>Validação QR</p>
  </a>
</div>

<div class="search">
  <span>🔍</span>
  <input id="q" type="search" placeholder="Pesquisar módulo ou portal..." oninput="filtrar()">
</div>

<p class="sec sec-title">Módulos Conectados</p>
<div class="list" id="mods">

  <a class="row" data-k="diretor admin gestão" href="https://sigar-nine.vercel.app/sigar_admin_firebase.html">
    <div class="ico c-blue">🏛️</div>
    <div class="body">
      <span class="badge c-blue">ADMIN</span>
      <h3>Painel do Diretor</h3>
      <p>Gestão global, turmas, cursos, alunos e relatórios</p>
      <div class="live">● Firebase Tempo Real</div>
    </div>
    <span class="go">→</span>
  </a>

  <a class="row" data-k="professor docência aulas" href="https://sigar-nine.vercel.app/sigar_professor.html">
    <div class="ico c-green">👨‍🏫</div>
    <div class="body">
      <span class="badge c-green">DOCÊNCIA</span>
      <h3>Painel do Professor</h3>
      <p>Avaliações, presença e gestão pedagógica</p>
      <div class="live">● Firebase Tempo Real</div>
    </div>
    <span class="go">→</span>
  </a>

  <a class="row" data-k="verificar certificado autenticidade qr" href="https://sigar-nine.vercel.app/verificar-1.html">
    <div class="ico c-purple">📜</div>
    <div class="body">
      <span class="badge c-purple">AUTENTICIDADE</span>
      <h3>Validação de Certificados</h3>
      <p>Verificação pública de certificados e diplomas</p>
      <div class="live">● Firebase Tempo Real</div>
    </div>
    <span class="go">→</span>
  </a>

  <a class="row" data-k="carta operador licença máquinas" href="https://sigar-nine.vercel.app/carta_operador-1.html">
    <div class="ico c-orange">🪪</div>
    <div class="body">
      <span class="badge c-orange">CARTA</span>
      <h3>Carta de Operador</h3>
      <p>Emissão e consulta de cartas de máquinas</p>
      <div class="live">● Firebase Tempo Real</div>
    </div>
    <span class="go">→</span>
  </a>

  <a class="row" data-k="inscrição público site" href="https://sigar-nine.vercel.app/">
    <div class="ico c-gold">📝</div>
    <div class="body">
      <span class="badge c-gold">PÚBLICO</span>
      <h3>Site de Inscrições</h3>
      <p>Inscrição online e pagamento M-Pesa / e-Mola</p>
      <div class="live">● Online</div>
    </div>
    <span class="go">→</span>
  </a>

  <a class="row" data-k="aluno estudante notas" href="https://sigar-nine.vercel.app/sigar_professor.html">
    <div class="ico c-cyan">🎒</div>
    <div class="body">
      <span class="badge c-cyan">ESTUDANTE</span>
      <h3>Painel do Aluno</h3>
      <p>Notas, faltas e histórico (publicar sigar_aluno.html)</p>
      <div class="live">○ Aguardar publicação</div>
    </div>
    <span class="go">→</span>
  </a>

</div>

<div class="hint">
  <b>Instalar como app:</b> no Chrome → menu ⋮ → <b>Adicionar ao ecrã inicial</b> / <b>Instalar aplicação</b>.  
  Fica com ícone como uma app nativa.
</div>

<nav class="nav">
  <a href="https://sigar-nine.vercel.app/"><span class="ni">🌐</span>Navegador</a>
  <a class="on" href="#"><span class="ni">▦</span>Módulos</a>
  <a href="https://sigar-nine.vercel.app/verificar-1.html"><span class="ni">🛡️</span>Validador</a>
  <a href="https://sigar-nine.vercel.app/sigar_admin_firebase.html"><span class="ni">⚙️</span>Admin</a>
</nav>

<script>
function filtrar(){
  const q=(document.getElementById('q').value||'').toLowerCase().trim();
  document.querySelectorAll('#mods .row').forEach(r=>{
    const k=(r.getAttribute('data-k')||'')+' '+(r.textContent||'');
    r.style.display=!q||k.toLowerCase().includes(q)?'flex':'none';
  });
}
</script>
</body>
</html>
