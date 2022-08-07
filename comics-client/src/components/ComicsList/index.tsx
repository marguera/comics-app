import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

import ComicLikes from '../ComicLikes';
import { Comic } from '../../data';
import { useEffect } from 'react';

interface ComicsListParams {
  comics: Comic[];
}

export default function ComicsList({ comics }: ComicsListParams) {

  if(comics.length === 0) {
    throw new Error('Comics list cannot be empty');
  }

  return (
    <Container as="ol">
      <Row as="li" className="comics-list justify-content-center">
        {comics.map((comic) => (
          <Col key={comic.id} className="comic-card p-0">
            <h3 className="comic-title m-0 p-3">{comic.title}</h3>
            <img src={comic.thumbnail} alt={`${comic.title} cover`} />
            <ComicLikes
              likes={comic.likes}
              isLiked={false}
              onLikeClick={() => {}}
            />
          </Col>
        ))}
      </Row>
    </Container>
  );
}
