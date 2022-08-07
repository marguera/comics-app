import React, { useState, useEffect } from 'react';

import Header from './components/Header';
import SearchForm from './components/SearchForm';

import ComicsList from './components/ComicsList';
import { getComics, Comic } from './data'

import './App.scss';

function App () {
  const [comics, setComics] = useState<Comic[]>([]);
  const [character, setCharacter] = useState('');

  const searchComics = (searchTerm: string): void => {
    getComics(searchTerm).then(response => {
      setComics(response.results);
    });
  };

  const onSubmit = (searchTerm: string) => {
    searchComics(searchTerm);
    setCharacter(searchTerm);
  };

  useEffect(() => {
    searchComics("");
  } , []);

  return (
    <div className="App">
      <Header />
      <SearchForm onSubmit={onSubmit} />
      <br />
      { comics.length > 0 && <ComicsList comics={comics} /> }
    </div>
  )
}

export default App
