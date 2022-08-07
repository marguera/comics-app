import React, { useState, useEffect } from 'react';
import styles from './ComicLikes.module.scss';

interface ComicLikesProps {
  isLiked: boolean
}

export default function ComicLikes({ isLiked }: ComicLikesProps) {

  const [ userLiked, setUserLiked ] = useState<boolean>(false);

  const handleClick = () => {
    if(!userLiked) {
      setUserLiked(true);
    }
  }

  useEffect(() => {
    setUserLiked(isLiked);
  }, []);

  return (
    <div className="comic-likes">
      <span>3</span>
      <button name="teste" 
        disabled={userLiked} 
        onClick={handleClick}
        className={styles.comicLikes} 
      />
    </div>
  );
};

