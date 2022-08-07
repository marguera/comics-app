import React from "react";
import ComicsList from "./index";
import { render, screen } from "@testing-library/react";
import { Comic } from "../../data";

describe("ComicsList", () => {

  it("should show the comics given", async () => {
    const comics: Comic[] = [{ 
      id: '1', 
      title: "comic title 1", 
      likes: 0, 
      thumbnail: "thumbnail", 
      isLiked: false 
    }, { 
      id: '2', 
      title: "comic title 2", 
      likes: 0, 
      thumbnail: "thumbnail", 
      isLiked: false 
    }];
    
    render(<ComicsList comics={comics} />);
    expect(await screen.findByText("comic title 1")).toBeInTheDocument();
    expect(await screen.findByText("comic title 2")).toBeInTheDocument();
  });

  it("should not accept empty lists", () => {
    expect(() => {
      render(<ComicsList comics={[]} />);
    }).toThrowError("Comics list cannot be empty");
  });


});
