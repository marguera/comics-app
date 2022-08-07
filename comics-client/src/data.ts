import axios from 'axios';

export type Comic = {
  id: string
  title: string
  thumbnail: string
  isLiked: boolean
  likes: number
}

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