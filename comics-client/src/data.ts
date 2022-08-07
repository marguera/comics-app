export async function getComics(character: string): Promise<Comic[]> {
  console.log('Fetching comics for ' + character);
  const response = await fetch(`/api/v1/comics?character=${character}`);
  return await response.json() as Comic[];
}

export type Comic = {
    id: string
    title: string
    thumbnail: string
    isLiked: boolean
    likes: number
}