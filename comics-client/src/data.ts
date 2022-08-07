import axios from 'axios';
import Comic from './definitions/Comic';

export type Links = {
  next?: number
  prev?: number
}

export type ComicsResponse = {
  _links: Links
  results: Comic[]
}

export type GetComicsParams = {
  character: string,
  page?: number,
}

export async function getComics(params: GetComicsParams): Promise<ComicsResponse> {
  let response = await axios.get('http://localhost:3000/api/v1/comics', { params });
  return response.data;
}

export function addLike(comicId:string): void {
  axios.post(`http://localhost:3000/api/v1/comics/${comicId}/like`);
}