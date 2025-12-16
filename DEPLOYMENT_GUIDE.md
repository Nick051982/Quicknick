# 🚀 Deployment Guide - Schritt für Schritt

Diese Anleitung führt Sie durch den kompletten Deployment-Prozess von Null bis zur Live-App.

## 📋 Voraussetzungen

- [ ] GitHub Account
- [ ] Vercel Account (kostenlos)
- [ ] Supabase Account (kostenlos)
- [ ] Git installiert auf Ihrem Computer

## 🎯 Teil 1: GitHub Repository erstellen

### Schritt 1.1: Neues Repository auf GitHub

1. Gehen Sie zu [github.com](https://github.com)
2. Klicken Sie auf das `+` Symbol → "New repository"
3. Geben Sie einen Namen ein: `fc-training-app`
4. Wählen Sie "Public" oder "Private"
5. **NICHT** "Initialize with README" anklicken
6. Klicken Sie auf "Create repository"

### Schritt 1.2: Lokalen Code nach GitHub pushen

Öffnen Sie ein Terminal im Projekt-Ordner:

```bash
# Git initialisieren (falls noch nicht geschehen)
git init

# Alle Dateien hinzufügen
git add .

# Ersten Commit erstellen
git commit -m "Initial commit - FC Training App"

# GitHub Repository verbinden (ersetzen Sie IHR-USERNAME)
git remote add origin https://github.com/IHR-USERNAME/fc-training-app.git

# Code hochladen
git branch -M main
git push -u origin main
```

✅ **Checkpoint:** Ihr Code ist jetzt auf GitHub!

## 🗄️ Teil 2: Supabase Datenbank Setup

### Schritt 2.1: Supabase Projekt erstellen

1. Gehen Sie zu [supabase.com](https://supabase.com)
2. Klicken Sie auf "Start your project"
3. Registrieren Sie sich (falls noch nicht geschehen)
4. Klicken Sie auf "New Project"
5. Füllen Sie aus:
   - **Name:** `fc-training`
   - **Database Password:** Wählen Sie ein sicheres Passwort (speichern Sie es!)
   - **Region:** Wählen Sie die nächstgelegene Region
   - **Pricing Plan:** Free
6. Klicken Sie auf "Create new project"
7. ⏳ Warten Sie ca. 2 Minuten bis das Projekt bereit ist

### Schritt 2.2: Project URL und API Key notieren

1. Im Supabase Dashboard, gehen Sie zu "Settings" (unten links)
2. Klicken Sie auf "API"
3. **Kopieren und speichern Sie:**
   - `Project URL` → Das ist Ihre `VITE_SUPABASE_URL`
   - `anon public` Key → Das ist Ihr `VITE_SUPABASE_ANON_KEY`

### Schritt 2.3: Datenbank Migration ausführen

1. Im Supabase Dashboard, klicken Sie auf "SQL Editor" (links)
2. Klicken Sie auf "New query"
3. Öffnen Sie die Datei `database/001_initial_setup.sql` auf Ihrem Computer
4. Kopieren Sie den **gesamten Inhalt**
5. Fügen Sie ihn in den SQL Editor ein
6. Klicken Sie auf "Run" (oder Strg/Cmd + Enter)
7. ✅ Sie sollten "Success. No rows returned" sehen

✅ **Checkpoint:** Ihre Datenbank ist fertig eingerichtet!

## ☁️ Teil 3: Vercel Deployment

### Schritt 3.1: Vercel Projekt erstellen

1. Gehen Sie zu [vercel.com](https://vercel.com)
2. Klicken Sie auf "Sign Up" (falls neu) oder "Log in"
3. Wählen Sie "Continue with GitHub"
4. Autorisieren Sie Vercel
5. Klicken Sie auf "Add New..." → "Project"
6. Importieren Sie Ihr Repository `fc-training-app`
7. Falls gefragt, geben Sie Vercel Zugriff auf das Repository

### Schritt 3.2: Projekt konfigurieren

Im Vercel Setup Screen:

1. **Framework Preset:** Sollte automatisch "Vite" erkennen
2. **Root Directory:** Lassen Sie `.` stehen
3. **Build Command:** `npm run build` (sollte schon da sein)
4. **Output Directory:** `dist` (sollte schon da sein)

### Schritt 3.3: Environment Variables hinzufügen

Scrollen Sie runter zu "Environment Variables":

1. Klicken Sie auf "Add"
2. **Erste Variable:**
   - Name: `VITE_SUPABASE_URL`
   - Value: [Ihre Supabase Project URL von Schritt 2.2]
   - Environments: Alle auswählen ✓
3. Klicken Sie auf "Add"
4. **Zweite Variable:**
   - Name: `VITE_SUPABASE_ANON_KEY`
   - Value: [Ihr Supabase Anon Key von Schritt 2.2]
   - Environments: Alle auswählen ✓
5. Klicken Sie auf "Add"

### Schritt 3.4: Deployment starten

1. Klicken Sie auf "Deploy"
2. ⏳ Warten Sie ca. 2-3 Minuten
3. 🎉 Wenn erfolgreich, sehen Sie Confetti!

### Schritt 3.5: App öffnen

1. Klicken Sie auf "Visit" oder den angezeigten Link
2. **Ihre App ist jetzt live!** 🚀

✅ **Checkpoint:** Ihre App ist online und erreichbar!

## ⚙️ Teil 4: GitHub Actions aktivieren

### Schritt 4.1: Vercel Token erstellen

1. Gehen Sie zu [vercel.com/account/tokens](https://vercel.com/account/tokens)
2. Klicken Sie auf "Create"
3. Name: `GitHub Actions`
4. Scope: Full Account
5. Expiration: No Expiration
6. Klicken Sie auf "Create Token"
7. **Kopieren Sie den Token sofort** (wird nur einmal angezeigt!)

### Schritt 4.2: Vercel IDs auslesen

Im Vercel Dashboard Ihres Projekts:

1. Gehen Sie zu "Settings"
2. Scrollen Sie zu "General"
3. **Kopieren Sie:**
   - **Project ID** (unter "Project ID")
   - **Team ID** oder **User ID** (je nachdem was Sie haben)

### Schritt 4.3: GitHub Secrets einrichten

1. Gehen Sie zu Ihrem GitHub Repository
2. Klicken Sie auf "Settings" (oben)
3. Links: "Secrets and variables" → "Actions"
4. Klicken Sie auf "New repository secret"

Fügen Sie nacheinander hinzu:

**Secret 1:**
- Name: `VERCEL_TOKEN`
- Value: [Der Token von Schritt 4.1]
- Klicken Sie auf "Add secret"

**Secret 2:**
- Name: `VERCEL_ORG_ID`
- Value: [Team/User ID von Schritt 4.2]
- Klicken Sie auf "Add secret"

**Secret 3:**
- Name: `VERCEL_PROJECT_ID`
- Value: [Project ID von Schritt 4.2]
- Klicken Sie auf "Add secret"

**Secret 4:**
- Name: `VITE_SUPABASE_URL`
- Value: [Ihre Supabase URL]
- Klicken Sie auf "Add secret"

**Secret 5:**
- Name: `VITE_SUPABASE_ANON_KEY`
- Value: [Ihr Supabase Anon Key]
- Klicken Sie auf "Add secret"

✅ **Checkpoint:** GitHub Actions ist fertig konfiguriert!

## 🧪 Teil 5: Automatisches Deployment testen

### Schritt 5.1: Änderung machen

Bearbeiten Sie z.B. `README.md`:
```bash
# Im Terminal
echo "Test" >> README.md
git add .
git commit -m "Test automatic deployment"
git push
```

### Schritt 5.2: Deployment verfolgen

1. Gehen Sie zu Ihrem GitHub Repository
2. Klicken Sie auf "Actions" (oben)
3. Sie sollten einen laufenden Workflow sehen
4. ⏳ Warten Sie ca. 2-3 Minuten
5. ✅ Workflow sollte grün werden (success)

6. Gehen Sie zu Vercel → Ihr Projekt
7. Sie sollten ein neues Deployment sehen!

🎉 **Glückwunsch! Automatisches Deployment funktioniert!**

## 👤 Teil 6: Ersten Admin-User erstellen

### Schritt 6.1: In der App registrieren

1. Öffnen Sie Ihre live App
2. Klicken Sie auf "Als Spieler anmelden"
3. Geben Sie Ihre E-Mail und Passwort ein
4. Registrieren Sie sich

### Schritt 6.2: Zu Admin upgraden

1. Gehen Sie zu Supabase Dashboard
2. Klicken Sie auf "Table Editor"
3. Wählen Sie die Tabelle "profiles"
4. Finden Sie Ihren Eintrag (Ihre E-Mail)
5. Doppelklicken Sie auf die "role" Spalte
6. Ändern Sie von `player` zu `admin`
7. Klicken Sie auf "Save"

### Schritt 6.3: Als Admin einloggen

1. Gehen Sie zurück zur App
2. Laden Sie die Seite neu (F5)
3. Loggen Sie sich aus und wieder ein
4. Klicken Sie jetzt auf "Als Admin anmelden"
5. 🎉 Sie haben jetzt Admin-Zugriff!

## ✅ Fertig! Zusammenfassung

Sie haben erfolgreich:

- ✅ Code auf GitHub hochgeladen
- ✅ Supabase Datenbank eingerichtet
- ✅ App auf Vercel deployed
- ✅ Automatisches Deployment konfiguriert
- ✅ Ersten Admin-User erstellt

## 📱 Nächste Schritte

1. **Erste Trainings anlegen** (im Admin-Bereich)
2. **Team-Mitglieder einladen** (URL teilen)
3. **App-Link speichern** (zum Homescreen auf Mobile)
4. **Feedback sammeln** und weitere Features entwickeln

## 🆘 Hilfe bei Problemen

### Problem: Vercel Build schlägt fehl
**Lösung:**
- Überprüfen Sie die Build Logs in Vercel
- Stellen Sie sicher, dass alle Environment Variables gesetzt sind
- Prüfen Sie ob `package.json` und `vercel.json` korrekt sind

### Problem: GitHub Actions schlägt fehl
**Lösung:**
- Überprüfen Sie alle 5 Secrets in GitHub
- Stellen Sie sicher, dass der Vercel Token gültig ist
- Prüfen Sie die Action Logs für Details

### Problem: Datenbank-Fehler
**Lösung:**
- Führen Sie die Migration erneut aus
- Überprüfen Sie die Supabase Logs
- Stellen Sie sicher, dass RLS Policies korrekt sind

### Problem: "Supabase client not configured"
**Lösung:**
- Überprüfen Sie ob Environment Variables in Vercel gesetzt sind
- Deployen Sie die App neu in Vercel
- Leeren Sie den Browser Cache

## 🎓 Weiterführende Ressourcen

- [Vercel Docs](https://vercel.com/docs)
- [Supabase Docs](https://supabase.com/docs)
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [React + TypeScript](https://react.dev)
- [Tailwind CSS](https://tailwindcss.com)

---

**Bei Fragen oder Problemen: Erstellen Sie ein Issue auf GitHub!**
