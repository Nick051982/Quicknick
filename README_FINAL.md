# ⚽ FC Training - Komplette Trainings-Anmeldung App

Eine vollständige Webanwendung für Fußballverein-Trainingsanmeldungen mit Gegenstands-Management.

## 🎯 Features

### ✅ Spieler-Bereich
- An-/Abmeldung zu Trainings
- Kommentar-Funktion
- 6 Mitbring-Optionen:
  - 🔑 Schlüssel
  - ⚽ Bälle
  - 💨 Pumpe
  - 👕 Leibchen
  - 🧤 Handschuhe
  - 🚕 Taxidienst
- **Gegenständ-Status** mit Rot/Grün-Markierung
  - 🟢 Grün = Gebucht
  - 🔴 Rot = Fehlt noch
- Alle Anmeldungen sichtbar
- Wer bringt was mit?

### ✅ Admin-Bereich
- Trainings erstellen/bearbeiten/löschen
- Teilnehmerliste mit Status
- Statistiken (Zusagen, freie Plätze)
- **Gegenständ-Status-Übersicht**
- Kommentare aller Spieler

## 🚀 Schnellstart

### 1. Repository klonen
```bash
git clone https://github.com/DEIN-USERNAME/fc-training-app.git
cd fc-training-app
```

### 2. Dependencies installieren
```bash
npm install
```

### 3. Supabase einrichten

#### 3.1 Projekt erstellen
1. Gehe zu [supabase.com](https://supabase.com)
2. Erstelle neues Projekt
3. Kopiere die URL und ANON_KEY

#### 3.2 Datenbank Migration
1. Gehe zu Supabase Dashboard → SQL Editor
2. Öffne `database/001_initial_setup.sql`
3. Kopiere den kompletten Inhalt
4. Führe das SQL Script aus

### 4. Environment Variables
```bash
cp .env.example .env.local
```

Fülle `.env.local` aus:
```
VITE_SUPABASE_URL=deine-projekt-url
VITE_SUPABASE_ANON_KEY=dein-anon-key
```

### 5. App starten
```bash
npm run dev
```

Öffne [http://localhost:5173](http://localhost:5173)

## 📦 Deployment auf Vercel

### Option 1: Mit Vercel CLI
```bash
npm install -g vercel
vercel
```

### Option 2: Mit GitHub Integration
1. Pushe Code zu GitHub
2. Gehe zu [vercel.com](https://vercel.com)
3. "New Project" → Repository auswählen
4. Environment Variables hinzufügen:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
5. Deploy!

## 🗄️ Datenbank Schema

### Tabellen

**profiles**
- User-Daten (id, email, full_name, role)

**trainings**
- Training-Daten (datum, zeit, ort, max_teilnehmer)

**anmeldungen**
- An-/Abmeldungen mit:
  - status (zugesagt/abgesagt/offen)
  - kommentar
  - schluessel_mitbringen
  - baelle_mitbringen
  - pumpe_mitbringen
  - leibchen_mitbringen
  - handschuhe_mitbringen
  - taxidienst_uebernehmen

### Row Level Security (RLS)
- ✅ Aktiviert
- Spieler sehen nur eigene Anmeldungen
- Admins haben vollen Zugriff

## 🛠️ Tech Stack

- **Frontend:** React 18 + TypeScript
- **Styling:** Tailwind CSS
- **Backend:** Supabase (PostgreSQL)
- **Build:** Vite
- **Deployment:** Vercel

## 📁 Projektstruktur

```
fc-training-app/
├── src/
│   ├── components/
│   │   ├── LoginView.tsx         # Login-Seite
│   │   ├── PlayerView.tsx        # Spieler-Dashboard
│   │   └── AdminView.tsx         # Admin-Dashboard
│   ├── lib/
│   │   └── supabase.ts           # Supabase Client
│   ├── App.tsx                   # Main App
│   └── main.tsx                  # Entry Point
├── database/
│   └── 001_initial_setup.sql     # DB Migration
├── public/                       # Static Assets
├── .env.example                  # Environment Template
├── package.json
├── vite.config.ts
├── tailwind.config.js
└── README.md
```

## 🎨 Design Features

### Farbcodierung
- 🟢 **Grün:** Zugesagt / Gebucht
- 🔴 **Rot:** Abgesagt / Fehlt noch
- ⚪ **Grau:** Offen / Neutral

### Responsive Design
- ✅ Mobile-optimiert
- ✅ Tablet-freundlich
- ✅ Desktop-Layout

## 🔐 Sicherheit

- Row Level Security (RLS) aktiviert
- Nur authentifizierte User
- Rollenbasierte Zugriffskontrolle
- HTTPS via Vercel

## 📝 Erste Schritte nach Installation

### Ersten Admin-User erstellen
1. Registriere ersten User in Supabase Auth
2. SQL ausführen:
```sql
UPDATE profiles 
SET role = 'admin' 
WHERE email = 'deine-admin@email.com';
```

### Test-Trainings erstellen
1. Login als Admin
2. "+ Neues Training erstellen"
3. Datum, Zeit, Ort eingeben
4. Speichern

## 🐛 Troubleshooting

### "Supabase client error"
- ✅ Überprüfe `.env.local` Variablen
- ✅ Starte Dev-Server neu: `npm run dev`

### "Database error"
- ✅ Migration wurde ausgeführt?
- ✅ RLS Policies wurden erstellt?
- ✅ Check Supabase Dashboard → Table Editor

### Build Fehler
```bash
rm -rf node_modules package-lock.json
npm install
npm run build
```

## 📚 Dokumentation

- [Supabase Docs](https://supabase.com/docs)
- [Vite Docs](https://vitejs.dev)
- [Tailwind Docs](https://tailwindcss.com/docs)
- [React Docs](https://react.dev)

## 🤝 Support

Bei Fragen oder Problemen:
1. Überprüfe DEPLOYMENT_GUIDE.md
2. Überprüfe Supabase Logs
3. Überprüfe Browser Console

## 📄 Lizenz

MIT License - Frei verwendbar

---

**Made with ⚽ for your football club**
