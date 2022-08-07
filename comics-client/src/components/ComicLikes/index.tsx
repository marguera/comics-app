import React, { useState, useEffect } from 'react';
import styles from './ComicLikes.module.scss';

interface ComicLikesProps {
  likes?: number;
  isLiked: boolean;
  onLikeClick: () => void;
}

export default function ComicLikes({ likes = 0, isLiked = false, onLikeClick }: ComicLikesProps) {

  const [ userLiked, setUserLiked ] = useState<boolean>(false);
  const [ likesCount, setLikesCount ] = useState<number>(0);

  const handleClick = () => {
    if(onLikeClick && !userLiked) {
      setUserLiked(true);
      setLikesCount(likesCount + 1);
      onLikeClick();
    }
  };

  useEffect(() => {
    setLikesCount(likes);
    setUserLiked(isLiked);
  }, []);

  return (
    <div className={styles.comicLikes} >
      <span>{likesCount}</span>
      <button name="teste" 
        disabled={userLiked} 
        onClick={handleClick}
      />
    </div>
  );
};

