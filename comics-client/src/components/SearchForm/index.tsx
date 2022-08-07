import React from 'react';
import { useState } from "react";
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import styles from './SearchForm.module.scss';

interface SearchFormProps {
  onSubmit: (character: string) => void;
}

export default function SearchForm(props: SearchFormProps) {
  const [searchTerm, setSearchTerm] = useState('');
  const [placeholder, setPlaceholder] = useState('Search for a character');

  const onSubmit = (event: React.FormEvent) => {
    setPlaceholder(searchTerm);
    setSearchTerm("");
    props.onSubmit(searchTerm);
    event.preventDefault();
  };

  const changeSearchTerm = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
  };

  return (
    <Container fluid as="header" className={styles.searchForm}>
      <Row className="justify-content-center p-3">
        <Col xs="auto">
          <form name="search-form" className="search-form" onSubmit={onSubmit}>
          <input
            className={styles.searchInput}
            name="character"
            type="text"
            id="name"
            value={searchTerm}
            placeholder={placeholder}
            onChange={changeSearchTerm}
          />
        </form>
        </Col>
      </Row>  
    </Container>
  );
}
