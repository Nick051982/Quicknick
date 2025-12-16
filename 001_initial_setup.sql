-- Migration: Initial Setup für FC Training App
-- Beschreibung: Erstellt alle notwendigen Tabellen und Beziehungen
-- Datum: 2025-12-16
-- Auszuführen im Supabase SQL Editor

-- ============================================================================
-- 1. USERS TABELLE (erweitert Supabase Auth)
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  role TEXT CHECK (role IN ('player', 'admin')) DEFAULT 'player',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Enable Row Level Security
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Policies für profiles
CREATE POLICY "Users can view their own profile" 
  ON public.profiles FOR SELECT 
  USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" 
  ON public.profiles FOR UPDATE 
  USING (auth.uid() = id);

CREATE POLICY "Admins can view all profiles" 
  ON public.profiles FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- ============================================================================
-- 2. TRAININGS TABELLE
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.trainings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  datum DATE NOT NULL,
  start_zeit TIME NOT NULL,
  end_zeit TIME NOT NULL,
  ort TEXT NOT NULL,
  max_teilnehmer INTEGER NOT NULL DEFAULT 20,
  beschreibung TEXT,
  created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Enable Row Level Security
ALTER TABLE public.trainings ENABLE ROW LEVEL SECURITY;

-- Policies für trainings
CREATE POLICY "Everyone can view trainings" 
  ON public.trainings FOR SELECT 
  TO authenticated 
  USING (true);

CREATE POLICY "Only admins can create trainings" 
  ON public.trainings FOR INSERT 
  TO authenticated 
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can update trainings" 
  ON public.trainings FOR UPDATE 
  TO authenticated 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can delete trainings" 
  ON public.trainings FOR DELETE 
  TO authenticated 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- ============================================================================
-- 3. ANMELDUNGEN TABELLE
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.anmeldungen (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  training_id UUID REFERENCES public.trainings(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  status TEXT CHECK (status IN ('zugesagt', 'abgesagt', 'offen')) DEFAULT 'offen',
  kommentar TEXT,
  schluessel_mitbringen BOOLEAN DEFAULT FALSE,
  baelle_mitbringen BOOLEAN DEFAULT FALSE,
  pumpe_mitbringen BOOLEAN DEFAULT FALSE,
  leibchen_mitbringen BOOLEAN DEFAULT FALSE,
  handschuhe_mitbringen BOOLEAN DEFAULT FALSE,
  taxidienst BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  UNIQUE(training_id, user_id)
);

-- Enable Row Level Security
ALTER TABLE public.anmeldungen ENABLE ROW LEVEL SECURITY;

-- Policies für anmeldungen
CREATE POLICY "Users can view their own anmeldungen" 
  ON public.anmeldungen FOR SELECT 
  TO authenticated 
  USING (auth.uid() = user_id);

CREATE POLICY "Admins can view all anmeldungen" 
  ON public.anmeldungen FOR SELECT 
  TO authenticated 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Users can create their own anmeldungen" 
  ON public.anmeldungen FOR INSERT 
  TO authenticated 
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own anmeldungen" 
  ON public.anmeldungen FOR UPDATE 
  TO authenticated 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own anmeldungen" 
  ON public.anmeldungen FOR DELETE 
  TO authenticated 
  USING (auth.uid() = user_id);

-- ============================================================================
-- 4. TRIGGER FÜR UPDATED_AT
-- ============================================================================

CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at_profiles
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at_trainings
  BEFORE UPDATE ON public.trainings
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at_anmeldungen
  BEFORE UPDATE ON public.anmeldungen
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();

-- ============================================================================
-- 5. INDICES FÜR PERFORMANCE
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_trainings_datum ON public.trainings(datum);
CREATE INDEX IF NOT EXISTS idx_anmeldungen_training_id ON public.anmeldungen(training_id);
CREATE INDEX IF NOT EXISTS idx_anmeldungen_user_id ON public.anmeldungen(user_id);
CREATE INDEX IF NOT EXISTS idx_profiles_role ON public.profiles(role);

-- ============================================================================
-- 6. VIEW FÜR TRAINING STATISTIKEN
-- ============================================================================

CREATE OR REPLACE VIEW public.training_stats AS
SELECT 
  t.id,
  t.datum,
  t.start_zeit,
  t.end_zeit,
  t.ort,
  t.max_teilnehmer,
  COUNT(CASE WHEN a.status = 'zugesagt' THEN 1 END) as anzahl_zugesagt,
  COUNT(CASE WHEN a.status = 'abgesagt' THEN 1 END) as anzahl_abgesagt,
  COUNT(CASE WHEN a.status = 'offen' THEN 1 END) as anzahl_offen,
  t.max_teilnehmer - COUNT(CASE WHEN a.status = 'zugesagt' THEN 1 END) as freie_plaetze
FROM public.trainings t
LEFT JOIN public.anmeldungen a ON t.id = a.training_id
GROUP BY t.id, t.datum, t.start_zeit, t.end_zeit, t.ort, t.max_teilnehmer;

-- ============================================================================
-- 7. BEISPIEL DATEN (Optional - nur für Testing)
-- ============================================================================

-- Uncomment für Testdaten:
/*
INSERT INTO public.trainings (datum, start_zeit, end_zeit, ort, max_teilnehmer, beschreibung) VALUES
  ('2025-12-18', '18:00', '19:30', 'Sportplatz Süd', 20, 'Reguläres Training'),
  ('2025-12-20', '18:00', '19:30', 'Sportplatz Süd', 20, 'Reguläres Training'),
  ('2025-12-23', '17:00', '18:30', 'Halle Nord', 16, 'Indoor Training');
*/

-- ============================================================================
-- Migration abgeschlossen
-- ============================================================================
