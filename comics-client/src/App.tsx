import './App.scss';
import { useState } from 'react'
import Header from './components/Header';
import SearchForm from './components/SearchForm';

function App () {
  const [character, setCharacter] = useState('Search for a character...');

  const onSubmit = (searchTerm: string) => {
    setCharacter(searchTerm);
  };

  return (
    <div className="App">
      <Header />
      <SearchForm placeHolderText={character} onSubmit={onSubmit} />
    </div>
  )
}

export default App
