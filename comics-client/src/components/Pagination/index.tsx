import Container from 'react-bootstrap/Container';

import { ButtonText } from '../../definitions/ButtonText';
import PagesLinks from '../../definitions/PagesLinks';
import styles from './Pagination.module.scss';

interface PaginationParams {
  links: PagesLinks;
  onPageChange?: (page: number) => void;
}

export default function Pagination(props: PaginationParams) {
  
  const prevPage = () => {
    console.log("WHY")
    if(props.onPageChange && props.links.prev) {
      props.onPageChange(props.links.prev);
    }
  };

  const nextPage = () => {
    if(props.onPageChange && props.links.next) {
      props.onPageChange(props.links.next);
    }
  };

  return (
    <Container className={styles.container}>
      <button 
        disabled={!props.links.prev} 
        onClick={prevPage}>
        {ButtonText.Previous}
      </button>
      <button 
        disabled={!props.links.next} 
        onClick={nextPage}>
        {ButtonText.Next}
      </button>
    </Container>
  );
}
