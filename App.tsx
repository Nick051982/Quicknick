import { useState } from 'react'
import LoginView from './components/LoginView'
import PlayerView from './components/PlayerView'
import AdminView from './components/AdminView'

type View = 'login' | 'player' | 'admin'

function App() {
  const [currentView, setCurrentView] = useState<View>('login')

  return (
    <>
      {currentView === 'login' && <LoginView onNavigate={setCurrentView} />}
      {currentView === 'player' && <PlayerView onNavigate={setCurrentView} />}
      {currentView === 'admin' && <AdminView onNavigate={setCurrentView} />}
    </>
  )
}

export default App
