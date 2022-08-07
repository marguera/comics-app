import './App.scss';
import { useState, useEffect } from 'react'
import { getComics, Comic } from './data'

import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

import Header from './components/Header';
import SearchForm from './components/SearchForm';
import ComicLikes from './components/ComicLikes';

function App () {
  const [comics, setComics] = useState<Comic[]>([]);
  const [character, setCharacter] = useState('Search for a character...');

  const searchComics = (searchTerm: string): void => {
    getComics(searchTerm).then(response => {
      setComics(response);
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
      <SearchForm placeHolderText={character} onSubmit={onSubmit} />
      <Container>
        <h2>Search Results</h2>
        <Row className="comics-list justify-content-center">
          {comics.map(comic => (
            <Col key={comic.id} className="comic-card p-0">
              <h3 className="comic-title m-0 p-3">{comic.title}</h3>
              <img src={comic.thumbnail} alt={`${comic.title} cover`} />
              <ComicLikes isLiked={false} />
            </Col>
          ))}
        </Row>
      </Container>
    </div>
  )
}

export default App
