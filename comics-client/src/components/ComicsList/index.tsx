import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';

import ComicsListItem from '../ComicsListItem';
import Comic from '../../definitions/Comic';

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
          <ComicsListItem key={comic.id} comic={comic} />
        ))}
      </Row>
    </Container>
  );
}
