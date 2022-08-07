import { useEffect, useState } from 'react';

import Col from 'react-bootstrap/Col';

import ComicLikes from '../ComicLikes';
import Comic from '../../definitions/Comic';
import { addLike } from '../../data';

import styles from './ComicsListItem.module.scss';

interface ComicsListItemProps {
    comic: Comic;
}

export default function ComicsListItem({ comic }: ComicsListItemProps) {

  const [liked, setLiked] = useState<boolean>(false);

  const onLikeClick = () => {
    addLike(comic.id);
    setLiked(true);
  };

  useEffect(() => {
    setLiked(comic.isLiked);
  }, [])

  return (
    <Col className={`p-0 ${styles.comicsListItem} ${liked ? styles.liked : ''}`}> 
      <h3 className={`${styles.comicTitle} m-0 p-3`}>{comic.title}</h3>
      <img src={comic.thumbnail} alt={`${comic.title} cover`} />
      <ComicLikes
        likes={comic.likes}
        isLiked={false}
        onLikeClick={onLikeClick} />
    </Col>
  )
};