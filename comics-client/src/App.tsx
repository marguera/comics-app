import './App.scss';
import { useState, useEffect } from 'react'
import { getComics, Comic } from './data'
import Header from './components/Header';
import SearchForm from './components/SearchForm';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

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
        <Row>
          {comics.map(comic => (
            <Col key={comic.id}>
              <h3>{comic.title}</h3>
              <img src={comic.thumbnail} alt={`${comic.title} cover`} />
              <div>
                <span>{comic.likes}</span>
                <button></button>
              </div>
            </Col>
          ))}
        </Row>
      </Container>
    </div>
  )
}

export default App
