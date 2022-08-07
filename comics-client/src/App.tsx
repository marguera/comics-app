import React, { useState, useEffect } from 'react';

import Header from './components/Header';
import SearchForm from './components/SearchForm';
import ComicsList from './components/ComicsList';
import Pagination from './components/Pagination';

import PagesLinks from './definitions/PagesLinks';
import Comic from './definitions/Comic';
import { getComics, addLike } from './data'

import './App.scss';

function App () {
  const [comics, setComics] = useState<Comic[]>([]);
  const [page, setPage] = useState(1);
  const [pagesLinks, setPagesLinks] = useState<PagesLinks>({});
  const [character, setCharacter] = useState('');
  
  const onSubmit = (searchTerm: string) => {
    setCharacter(searchTerm);
    setPagesLinks({});
    setPage(1);
  };

  const onPageChange = (newPage: number) => {
    setPagesLinks({});
    setPage(newPage);
  };

  useEffect(() => {
    getComics({ character, page }).then(response => {
      setComics(response.results);
      setPagesLinks(response._links);
    });
  } , [character, page]);

  return (
    <div className="App">
      <Header />
      <SearchForm onSubmit={onSubmit} />
      <br />
      { comics.length > 0 && <ComicsList comics={comics} /> }
      <Pagination 
        links={pagesLinks} 
        onPageChange={onPageChange} />
    </div>
  )
}

export default App
