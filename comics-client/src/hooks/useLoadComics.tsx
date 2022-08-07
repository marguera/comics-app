import { useState, useEffect } from 'react';
import { getComics, ComicsResponse } from '../data'


export default function useLoadComics() {
    const [data, setData] = useState<ComicsResponse>({} as ComicsResponse);
    const [character, setCharacter] = useState('');
    const [page, setPage] = useState(1);
    const [isLoading, setIsLoading] = useState(false);

    useEffect(() => {
        setIsLoading(true);
        getComics({ character, page }).then(response => {
            setData(response);
            setIsLoading(false);
        });
      } , [character, page]);

    return [ data, isLoading, setPage, setCharacter ];
}