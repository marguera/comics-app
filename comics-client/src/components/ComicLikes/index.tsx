import React, { useState, useEffect } from 'react';
import styles from './ComicLikes.module.scss';

interface ComicLikesProps {
  isLiked: boolean
  onLikeClick?: () => void
}

export default function ComicLikes({ isLiked = false, onLikeClick }: ComicLikesProps) {

  const [ userLiked, setUserLiked ] = useState<boolean>(false);

  const handleClick = () => {
    if(onLikeClick && !userLiked) {
      setUserLiked(true);
      onLikeClick();
    }
  }

  useEffect(() => {
    setUserLiked(isLiked);
  }, []);

  return (
    <div className="comic-likes">
      <button name="teste" 
        disabled={userLiked} 
        onClick={handleClick}
        className={styles.comicLikes} 
      />
    </div>
  );
};

