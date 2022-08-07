import React, { useState, useEffect } from 'react';

import Container from 'react-bootstrap/Container';

import SearchForm from './components/SearchForm';
import ComicsList from './components/ComicsList';
import Pagination from './components/Pagination';
import Header from './components/Header';

import PagesLinks from './definitions/PagesLinks';
import { AppText } from './definitions/AppText';
import Comic from './definitions/Comic';
import { getComics } from './data'

import styles from './App.module.scss';
import './App.scss';

function App () {
  const [comics, setComics] = useState<Comic[]>([]);
  const [page, setPage] = useState(1);
  const [pagesLinks, setPagesLinks] = useState<PagesLinks>({});
  const [character, setCharacter] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  
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
    setIsLoading(true);
    getComics({ character, page }).then(response => {
      setComics(response.results);
      setPagesLinks(response._links);
      setIsLoading(false);
    });
  } , [character, page]);

  return (
    <div className="App">
      <Header />
      <SearchForm onSubmit={onSubmit} />
      <Container fluid className={styles.container}>
        <div className={`${styles.loader} ${isLoading && styles.isLoading}`}>
          <div className={`${styles.ldsRoller} ${isLoading && styles.isLoading}`}>
            <div></div><div></div><div></div>
            <div></div><div></div><div></div>
            <div></div><div></div>
          </div>
        </div>
        { comics.length > 0 && (
          <>
            <ComicsList comics={comics} />
            <Pagination 
              links={pagesLinks} 
              onPageChange={onPageChange} />
          </>
        )}
        { !isLoading && comics.length === 0 && (
          <div className={styles.noResults}>
            <h2>{AppText.NO_COMICS_FOUND}</h2>
          </div>
        )}
      </Container>
    </div>
  )
}

export default App
