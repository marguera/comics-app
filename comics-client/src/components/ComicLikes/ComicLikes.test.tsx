import React from "react";
import ComicLikes from './index';
import { render } from '@testing-library/react';

describe("ComicLikes", () => {

  it("should be disabled if the comic is already liked", async () => {
    const { findByRole } = render(<ComicLikes isLiked={true} />);
    const button = await findByRole("button");
    console.log(button);
    expect(button).toHaveAttribute('disabled');
  });
  
});
