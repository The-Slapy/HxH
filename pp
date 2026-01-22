<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Gestor Calidad V3 - Mobile Friendly</title>
    <style>
        :root {
            --primary: #2563eb;
            --bg: #f3f4f6;
            --card: #ffffff;
            --text: #1f2937;
            --border: #e2e8f0;
            --danger: #ef4444;
            --warning: #f59e0b;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg);
            color: var(--text);
            margin: 0;
            padding: 10px; /* Menos padding en móvil */
        }

        /* --- CONTENEDORES --- */
        .container { max-width: 1200px; margin: 0 auto; padding-bottom: 80px; }

        /* --- HEADER Y BOTONES --- */
        header {
            background: var(--card);
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 15px;
        }

        h1 { margin: 0 0 10px 0; color: var(--primary); font-size: 1.4rem; }

        .controls {
            display: flex;
            gap: 8px;
            overflow-x: auto; /* Scroll horizontal si hay muchos botones */
            padding-bottom: 5px;
        }

        button {
            padding: 10px 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
            touch-action: manipulation; /* Mejor respuesta táctil */
        }

        .btn-primary { background-color: var(--primary); color: white; box-shadow: 0 2px 5px rgba(37, 99, 235, 0.3); }
        .btn-outline { background: white; border: 1px solid var(--primary); color: var(--primary); }
        .btn-danger { background-color: var(--danger); color: white; }
        .btn-warning { background-color: var(--warning); color: white; }
        
        /* Botón flotante para agregar en móvil */
        .fab {
            display: none;
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: var(--primary);
            color: white;
            width: 56px; height: 56px;
            border-radius: 50%;
            font-size: 24px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            justify-content: center;
            align-items: center;
            z-index: 100;
        }

        /* --- BUSCADOR --- */
        .search-bar {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 16px;
            box-sizing: border-box;
            background: white;
        }

        /* --- TABLA (SOLO DESKTOP) Y CARDS (MÓVIL) --- */
        .table-container { background: var(--card); border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th, td { text-align: left; padding: 12px; border-bottom: 1px solid var(--border); vertical-align: top; }
        th { background-color: #f8fafc; font-weight: 700; color: #64748b; }

        /* ESTILOS RESPONSIVOS (MAGIA PARA EL MÓVIL) */
        @media (max-width: 768px) {
            .fab { display: flex; } /* Mostrar botón flotante */
            .btn-add-desktop { display: none; } /* Ocultar botón normal */
            
            /* Transformar tabla en tarjetas */
            thead { display: none; }
            table, tbody, tr, td { display: block; width: 100%; box-sizing: border-box; }
            
            tr {
                margin-bottom: 15px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
                border: 1px solid var(--border);
                overflow: hidden;
            }

            td {
                padding: 10px 15px;
                border-bottom: 1px solid #f1f5f9;
                text-align: left;
            }
            
            td:last-child { border-bottom: none; background: #f8fafc; display: flex; justify-content: flex-end; gap: 10px;}

            /* Estilos específicos para celdas en modo tarjeta */
            .mobile-label { display: block; font-size: 0.75rem; color: #64748b; margin-bottom: 4px; text-transform: uppercase; letter-spacing: 0.5px; }
            .model-text { font-size: 1.1rem; font-weight: bold; color: var(--primary); }
        }

        /* --- DETALLES VISUALES --- */
        .side-info { padding: 8px; border-radius: 6px; font-size: 0.9em; margin-top: 5px; }
        .info-top { background: #eff6ff; border-left: 4px solid #2563eb; }
        .info-bot { background: #fdf2f8; border-left: 4px solid #db2777; }
        .info-na { color: #94a3b8; font-style: italic; background: #f1f5f9; }

        .job-pill {
            display: flex;
            justify-content: space-between;
            background: white;
            border: 1px solid #cbd5e1;
            padding: 4px 8px;
            border-radius: 4px;
            margin-top: 4px;
            font-size: 0.85em;
        }

        /* --- MODAL --- */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.6);
            justify-content: center;
            align-items: flex-start;
            padding-top: 20px;
            overflow-y: auto;
            z-index: 1000;
            backdrop-filter: blur(2px);
        }

        .modal-content {
            background: var(--card);
            padding: 20px;
            border-radius: 12px;
            width: 95%;
            max-width: 800px;
            margin-bottom: 80px; /* Espacio para scroll en móvil */
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .close-modal { background: none; color: #666; font-size: 24px; padding: 0; }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .full-width { grid-column: 1 / -1; }

        @media (max-width: 768px) {
            .form-grid { grid-template-columns: 1fr; }
        }

        .side-box {
            background: #f8fafc;
            border: 1px solid var(--border);
            padding: 15px;
            border-radius: 10px;
        }
        
        .side-box.disabled { opacity: 0.5; pointer-events: none; background: #e2e8f0; }

        .side-title {
            font-weight: 800;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .input-group { margin-bottom: 10px; }
        label { display: block; margin-bottom: 4px; font-weight: 600; font-size: 0.9rem; }
        
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 16px; /* Evita zoom en iPhone */
            box-sizing: border-box;
        }

        /* Job Input Row */
        .job-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 8px;
            margin-bottom: 8px;
            background: white;
            padding: 8px;
            border-radius: 6px;
            border: 1px dashed #cbd5e1;
        }
    </style>
</head>
<body>

<div class="container">
    <header>
        <h1>🏭 Registro Calidad</h1>
        <div class="controls">
            <input type="file" id="importFile" accept=".json" style="display: none;">
            <button class="btn-outline" onclick="document.getElementById('importFile').click()">📂 Importar</button>
            <button class="btn-outline" onclick="exportData()">💾 Exportar</button>
            <button class="btn-primary btn-add-desktop" onclick="openModal()">+ Nuevo</button>
        </div>
    </header>

    <input type="text" id="searchInput" class="search-bar" placeholder="🔍 Buscar modelo, línea..." onkeyup="filterData()">

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th style="width: 20%">Info Producto</th>
                    <th style="width: 35%">Lado TOP</th>
                    <th style="width: 35%">Lado BOT</th>
                    <th style="width: 10%">Acciones</th>
                </tr>
            </thead>
            <tbody id="tableBody">
                </tbody>
        </table>
    </div>
</div>

<button class="fab" onclick="openModal()">+</button>

<div id="modal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 id="modalTitle" style="margin:0;">Nuevo Registro</h2>
            <button class="close-modal" onclick="closeModal()">×</button>
        </div>

        <form id="dataForm">
            <input type="hidden" id="editId">

            <div class="form-grid" style="margin-bottom: 20px; background: #fff; padding: 10px; border-radius: 8px;">
                <div class="input-group">
                    <label>Modelo:</label>
                    <input type="text" id="model" required placeholder="Ej. X-1000">
                </div>
                <div class="input-group">
                    <label>No. Producto:</label>
                    <input type="text" id="productNo" required placeholder="Ej. 998877">
                </div>
            </div>

            <div class="form-grid">
                
                <div class="side-box" id="boxTop">
                    <div class="side-title" style="color: #1e40af;">
                        TOP SIDE
                        <label style="font-weight: normal; font-size: 0.8rem; display:flex; align-items:center; gap:5px;">
                            <input type="checkbox" id="naTop" onchange="toggleSide('Top')" style="width:auto;"> N/A
                        </label>
                    </div>
                    
                    <div class="input-group">
                        <label>Línea:</label>
                        <input type="text" id="lineTop" placeholder="Línea A">
                    </div>
                    <div class="input-group">
                        <label>Jobs:</label>
                        <select id="jobCountTop" onchange="renderJobInputs('Top')">
                            <option value="1">1 Job</option>
                            <option value="2">2 Jobs</option>
                            <option value="3">3 Jobs</option>
                        </select>
                    </div>
                    <div id="dynamicJobsTop"></div>
                </div>

                <div class="side-box" id="boxBot">
                    <div class="side-title" style="color: #db2777;">
                        BOT SIDE
                        <label style="font-weight: normal; font-size: 0.8rem; display:flex; align-items:center; gap:5px;">
                            <input type="checkbox" id="naBot" onchange="toggleSide('Bot')" style="width:auto;"> N/A
                        </label>
                    </div>
                    
                    <div class="input-group">
                        <label>Línea: <span onclick="copyLineToBot()" style="color:var(--primary); font-size:0.8em; text-decoration:underline;">(Copiar Top)</span></label>
                        <input type="text" id="lineBot" placeholder="Línea B">
                    </div>
                    <div class="input-group">
                        <label>Jobs:</label>
                        <select id="jobCountBot" onchange="renderJobInputs('Bot')">
                            <option value="1">1 Job</option>
                            <option value="2">2 Jobs</option>
                            <option value="3">3 Jobs</option>
                        </select>
                    </div>
                    <div id="dynamicJobsBot"></div>
                </div>

            </div>

            <div style="margin-top: 25px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                <button type="button" class="btn-danger" style="justify-content:center;" onclick="closeModal()">Cancelar</button>
                <button type="submit" class="btn-primary" style="justify-content:center;" id="saveBtn">Guardar</button>
            </div>
        </form>
    </div>
</div>

<script>
    let database = [];
    let isEditing = false;

    // --- INICIALIZAR ---
    document.addEventListener('DOMContentLoaded', () => {
        renderTable();
    });

    // --- RENDERIZAR INPUTS DE JOBS ---
    function renderJobInputs(side, existingJobs = null) {
        const count = parseInt(document.getElementById(`jobCount${side}`).value);
        const container = document.getElementById(`dynamicJobs${side}`);
        container.innerHTML = '';

        for (let i = 1; i <= count; i++) {
            const nameVal = existingJobs && existingJobs[i-1] ? existingJobs[i-1].name : '';
            const defVal = existingJobs && existingJobs[i-1] ? existingJobs[i-1].defects : '';
            
            const div = document.createElement('div');
            div.className = 'job-row';
            div.innerHTML = `
                <div>
                    <input type="text" class="job-name-${side}" data-idx="${i}" 
                           value="${nameVal}" placeholder="Nombre Job ${i}" required>
                </div>
                <div>
                    <input type="number" min="0" class="job-def-${side}" data-idx="${i}" 
                           value="${defVal}" placeholder="Def." required>
                </div>
            `;
            container.appendChild(div);
        }
    }

    // --- LOGICA MODAL ---
    function openModal(editItem = null) {
        const modal = document.getElementById('modal');
        document.getElementById('dataForm').reset();
        modal.style.display = 'flex';

        if (editItem) {
            isEditing = true;
            document.getElementById('modalTitle').innerText = "Editar";
            document.getElementById('saveBtn').innerText = "Actualizar";
            document.getElementById('editId').value = editItem.id;

            // Cargar General
            document.getElementById('model').value = editItem.model;
            document.getElementById('productNo').value = editItem.productNo;

            // Cargar Lados
            loadSideData('Top', editItem.top);
            loadSideData('Bot', editItem.bot);
        } else {
            isEditing = false;
            document.getElementById('modalTitle').innerText = "Nuevo";
            document.getElementById('saveBtn').innerText = "Guardar";
            
            // Default reset
            renderJobInputs('Top');
            renderJobInputs('Bot');
            toggleSide('Top'); // Asegura estado correcto visual
            toggleSide('Bot');
        }
    }

    function loadSideData(side, data) {
        const checkbox = document.getElementById(`na${side}`);
        checkbox.checked = data.na;
        toggleSide(side); // Activa/Desactiva visualmente

        if (!data.na) {
            document.getElementById(`line${side}`).value = data.line;
            document.getElementById(`jobCount${side}`).value = data.jobs.length;
            renderJobInputs(side, data.jobs);
        } else {
            renderJobInputs(side); // Reset limpio
        }
    }

    function closeModal() {
        document.getElementById('modal').style.display = 'none';
    }

    function toggleSide(side) {
        const isNA = document.getElementById(`na${side}`).checked;
        const box = document.getElementById(`box${side}`);
        if(isNA) box.classList.add('disabled');
        else box.classList.remove('disabled');
    }

    function copyLineToBot() {
        document.getElementById('lineBot').value = document.getElementById('lineTop').value;
    }

    // --- RECOLECTAR DATOS ---
    function getSideDataFromForm(side) {
        const isNA = document.getElementById(`na${side}`).checked;
        if (isNA) return { na: true, line: '', jobs: [] };

        const line = document.getElementById(`line${side}`).value;
        const count = parseInt(document.getElementById(`jobCount${side}`).value);
        const jobs = [];

        const names = document.querySelectorAll(`.job-name-${side}`);
        const defects = document.querySelectorAll(`.job-def-${side}`);

        for(let i=0; i<names.length; i++) {
            jobs.push({
                id: i+1,
                name: names[i].value,
                defects: parseInt(defects[i].value) || 0
            });
        }

        return { na: false, line: line, jobs: jobs };
    }

    document.getElementById('dataForm').addEventListener('submit', (e) => {
        e.preventDefault();
        
        const record = {
            id: isEditing ? parseInt(document.getElementById('editId').value) : Date.now(),
            model: document.getElementById('model').value,
            productNo: document.getElementById('productNo').value,
            top: getSideDataFromForm('Top'),
            bot: getSideDataFromForm('Bot')
        };

        if (isEditing) {
            const idx = database.findIndex(r => r.id === record.id);
            if(idx !== -1) database[idx] = record;
        } else {
            database.push(record);
        }

        renderTable();
        closeModal();
    });

    // --- TABLA Y RENDER ---
    function renderTable(data = database) {
        const tbody = document.getElementById('tableBody');
        tbody.innerHTML = '';

        if(data.length === 0) {
            tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; padding:20px; color:#888;">No hay registros.</td></tr>';
            return;
        }

        data.forEach(rec => {
            const tr = document.createElement('tr');
            
            // Función auxiliar para renderizar lado
            const renderSide = (info, type) => {
                if(info.na) return '<div class="side-info info-na">N/A</div>';
                let jobsHtml = info.jobs.map(j => `
                    <div class="job-pill">
                        <span>${j.name}</span>
                        <b>${j.defects} def.</b>
                    </div>
                `).join('');
                
                return `
                    <div class="side-info info-${type.toLowerCase()}">
                        <div style="margin-bottom:4px;"><b>Línea:</b> ${info.line}</div>
                        ${jobsHtml}
                    </div>
                `;
            };

            tr.innerHTML = `
                <td>
                    <span class="mobile-label">Producto</span>
                    <div class="model-text">${rec.model}</div>
                    <div style="color:#64748b; font-size:0.9rem;">#${rec.productNo}</div>
                </td>
                <td>
                    <span class="mobile-label">Top Side</span>
                    ${renderSide(rec.top, 'Top')}
                </td>
                <td>
                    <span class="mobile-label">Bot Side</span>
                    ${renderSide(rec.bot, 'Bot')}
                </td>
                <td>
                    <button class="btn-warning" onclick="editRecord(${rec.id})" style="padding:6px 10px; font-size:12px;">✏️</button>
                    <button class="btn-danger" onclick="deleteRecord(${rec.id})" style="padding:6px 10px; font-size:12px;">🗑️</button>
                </td>
            `;
            tbody.appendChild(tr);
        });
    }

    function editRecord(id) {
        const rec = database.find(r => r.id === id);
        if(rec) openModal(rec);
    }

    function deleteRecord(id) {
        if(confirm('¿Borrar este registro?')) {
            database = database.filter(r => r.id !== id);
            renderTable();
        }
    }

    function filterData() {
        const q = document.getElementById('searchInput').value.toLowerCase();
        const filtered = database.filter(item => {
            return JSON.stringify(item).toLowerCase().includes(q);
        });
        renderTable(filtered);
    }

    function exportData() {
        const dataStr = JSON.stringify(database, null, 2);
        const blob = new Blob([dataStr], { type: "application/json" });
        const a = document.createElement('a');
        a.href = URL.createObjectURL(blob);
        a.download = `calidad_db_${new Date().toISOString().slice(0,10)}.json`;
        a.click();
    }

    document.getElementById('importFile').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if(!file) return;
        const reader = new FileReader();
        reader.onload = function(ev) {
            try {
                const json = JSON.parse(ev.target.result);
                if(Array.isArray(json)) {
                    database = json;
                    renderTable();
                    alert("Importado con éxito");
                }
            } catch(err) { alert("Error en archivo"); }
        };
        reader.readAsText(file);
        e.target.value = '';
    });
</script>

</body>
</html>
