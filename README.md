# ⚽ FC Training App

Eine moderne Web-App für Fußballvereine zur Online-Anmeldung für Trainings.

## 🚀 Tech Stack

- **Frontend:** React 18 + TypeScript
- **Styling:** Tailwind CSS
- **Backend/DB:** Supabase (PostgreSQL)
- **Build Tool:** Vite
- **Deployment:** Vercel
- **CI/CD:** GitHub Actions

## 📋 Features

### Für Spieler:
- ✅ Login/Authentifizierung
- ✅ Übersicht aller kommenden Trainings
- ✅ Zu-/Absagen für Trainings
- ✅ Eigene Anmeldungen verwalten
- ✅ Mobile-optimiert

### Für Admins:
- ✅ Trainings erstellen, bearbeiten, löschen
- ✅ Teilnehmerlisten einsehen
- ✅ Statistiken (Zusagen, Absagen, freie Plätze)
- ✅ Spielerverwaltung

## 🛠️ Installation & Setup

### 1. Repository klonen

```bash
git clone https://github.com/IHR-USERNAME/fc-training-app.git
cd fc-training-app
```

### 2. Dependencies installieren

```bash
npm install
```

### 3. Supabase Setup

#### 3.1 Supabase Projekt erstellen
1. Gehen Sie zu [supabase.com](https://supabase.com)
2. Erstellen Sie ein kostenloses Konto
3. Erstellen Sie ein neues Projekt
4. Notieren Sie sich:
   - Project URL
   - Anon Public Key

#### 3.2 Datenbank Migration ausführen
1. Öffnen Sie im Supabase Dashboard: `SQL Editor`
2. Kopieren Sie den Inhalt von `database/001_initial_setup.sql`
3. Fügen Sie ihn in den SQL Editor ein
4. Klicken Sie auf "Run"

#### 3.3 Environment Variables einrichten
1. Kopieren Sie `.env.example` zu `.env`:
   ```bash
   cp .env.example .env
   ```

2. Fügen Sie Ihre Supabase Credentials ein:
   ```env
   VITE_SUPABASE_URL=https://ihr-projekt.supabase.co
   VITE_SUPABASE_ANON_KEY=ihr-anon-key
   ```

### 4. Lokale Entwicklung starten

```bash
npm run dev
```

Die App läuft jetzt auf `http://localhost:5173`

## 🚢 Deployment auf Vercel

### Methode 1: Vercel CLI (Empfohlen)

1. **Vercel CLI installieren:**
   ```bash
   npm i -g vercel
   ```

2. **Login:**
   ```bash
   vercel login
   ```

3. **Projekt deployen:**
   ```bash
   vercel
   ```

4. **Environment Variables in Vercel setzen:**
   ```bash
   vercel env add VITE_SUPABASE_URL
   vercel env add VITE_SUPABASE_ANON_KEY
   ```

5. **Production Deployment:**
   ```bash
   vercel --prod
   ```

### Methode 2: Vercel Dashboard

1. Gehen Sie zu [vercel.com](https://vercel.com)
2. Klicken Sie auf "Add New Project"
3. Importieren Sie Ihr GitHub Repository
4. Konfigurieren Sie:
   - Framework: Vite
   - Build Command: `npm run build`
   - Output Directory: `dist`
5. Fügen Sie Environment Variables hinzu:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
6. Klicken Sie auf "Deploy"

## ⚙️ GitHub Actions Setup

Die App ist bereits mit automatischem Deployment konfiguriert. Bei jedem Push auf `main` wird:
1. ✅ Code gebaut
2. ✅ Build komprimiert
3. ✅ Auf Vercel deployed

### GitHub Secrets einrichten:

Gehen Sie zu `Settings > Secrets and variables > Actions` und fügen Sie hinzu:

1. **VERCEL_TOKEN**: 
   - Erstellen unter: https://vercel.com/account/tokens

2. **VERCEL_ORG_ID**: 
   ```bash
   vercel link
   cat .vercel/project.json
   ```

3. **VERCEL_PROJECT_ID**: 
   ```bash
   # Aus der gleichen Datei wie ORG_ID
   cat .vercel/project.json
   ```

4. **VITE_SUPABASE_URL**: Ihre Supabase Projekt URL

5. **VITE_SUPABASE_ANON_KEY**: Ihr Supabase Anon Key

## 📁 Projekt-Struktur

```
fc-training-app/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions Workflow
├── database/
│   └── 001_initial_setup.sql   # Supabase Migration Script
├── public/
├── src/
│   ├── components/
│   │   ├── LoginView.tsx       # Login Seite
│   │   ├── PlayerView.tsx      # Spieler Dashboard
│   │   └── AdminView.tsx       # Admin Dashboard
│   ├── lib/
│   │   └── supabase.ts         # Supabase Client
│   ├── App.tsx                 # Haupt App Komponente
│   ├── main.tsx                # Entry Point
│   └── index.css               # Global Styles
├── .env.example                # Environment Template
├── .gitignore
├── index.html
├── package.json
├── tailwind.config.js
├── tsconfig.json
├── vercel.json                 # Vercel Konfiguration
└── vite.config.ts
```

## 🗄️ Datenbank Schema

### Tabellen:

1. **profiles** - Benutzerprofile (erweitert Supabase Auth)
   - id, email, full_name, role (player/admin)

2. **trainings** - Trainingseinheiten
   - id, datum, start_zeit, end_zeit, ort, max_teilnehmer

3. **anmeldungen** - An-/Abmeldungen
   - id, training_id, user_id, status (zugesagt/abgesagt/offen)

### Views:
- **training_stats** - Automatische Statistiken für jedes Training

## 🔒 Sicherheit (Row Level Security)

- ✅ Spieler sehen nur ihre eigenen Daten
- ✅ Admins haben vollen Zugriff
- ✅ Alle Policies sind in der Migration definiert

## 🧪 Testing

```bash
# Build lokal testen
npm run build
npm run preview
```

## 📦 Build-Prozess

Der Build-Prozess ist optimiert für:
- ✅ Code Minifizierung (Terser)
- ✅ Tree Shaking
- ✅ Lazy Loading
- ✅ Gzip Kompression (via GitHub Actions)

## 🐛 Troubleshooting

### Problem: "Supabase client not configured"
**Lösung:** Überprüfen Sie Ihre `.env` Datei und stellen Sie sicher, dass die Variablen korrekt gesetzt sind.

### Problem: "Database error: relation does not exist"
**Lösung:** Führen Sie die Migration `001_initial_setup.sql` im Supabase SQL Editor aus.

### Problem: Vercel Deployment schlägt fehl
**Lösung:** 
1. Überprüfen Sie GitHub Secrets
2. Stellen Sie sicher, dass `vercel.json` im Root liegt
3. Prüfen Sie die Vercel Build Logs

## 📝 Nächste Schritte

Nach dem erfolgreichen Deployment:

1. **Admin-User erstellen:**
   - Registrieren Sie sich in der App
   - Ändern Sie in Supabase die `role` auf `admin`:
     ```sql
     UPDATE profiles SET role = 'admin' WHERE email = 'ihre-email@example.com';
     ```

2. **Erste Trainings anlegen:**
   - Loggen Sie sich als Admin ein
   - Erstellen Sie Trainings über den Admin-Bereich

3. **Spieler einladen:**
   - Teilen Sie die App-URL mit Ihrem Team
   - Spieler können sich selbst registrieren

## 🤝 Mitwirken

Pull Requests sind willkommen! Für größere Änderungen öffnen Sie bitte zuerst ein Issue.

## 📄 Lizenz

MIT

## 👤 Autor

Ihr Name / Ihr Verein

---

**Viel Erfolg mit Ihrer FC Training App! ⚽**

Bei Fragen: [GitHub Issues](https://github.com/IHR-USERNAME/fc-training-app/issues)
Trigger rebuiold
