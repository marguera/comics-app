import React from 'react';
import Container from 'react-bootstrap/Container';
import MarvelLogo from '../images/marvel_logo.png';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import styles from './Header.module.scss';

export default function Header() {
  return (
    <Container fluid as="header" className={styles.header}>
      <Row className="justify-content-center">
        <Col xs="auto" className="logo">
          <img src={MarvelLogo} alt="Marvel Logo" />
        </Col>
      </Row>
    </Container>
  );
}
