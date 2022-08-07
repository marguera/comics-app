import React from "react";
import ComicsListItem from "./index";
import { render, screen } from "@testing-library/react";
import Comic from "../../definitions/Comic";

describe("ComicsListItem", () => {

  it("should show the comic given", async () => {
    const comic: Comic = { 
      id: '1', 
      title: "comic title 1", 
      likes: 0, 
      thumbnail: "thumbnail", 
      liked: false 
    };
    render(<ComicsListItem comic={comic} />);
    expect(await screen.findByText("comic title 1")).toBeInTheDocument();
  });
});
