import React from "react";
import ComicLikes from './index';
import { render, fireEvent } from '@testing-library/react';

describe("ComicLikes", () => {

  it("should be disabled if the comic is already liked", async () => {
    const { findByRole } = render(<ComicLikes isLiked={true} />);
    const button = await findByRole("button");
    console.log(button);
    expect(button).toHaveAttribute('disabled');
  });

  it("calls the callback function if given", () => {
    const mockCallback = jest.fn();
    const { getByRole } = render(<ComicLikes isLiked={false} onLikeClick={mockCallback} />);
    const button = getByRole("button");
    fireEvent.click(button);
    expect(mockCallback.mock.calls.length).toBe(1);
  });

});
