import React from "react";
import ComicLikes from './index';
import { render, fireEvent } from '@testing-library/react';

describe("ComicLikes", () => {

  it("should be enabled if the comic is not liked", async () => {
    const { findByRole } = render(<ComicLikes isLiked={false} onLikeClick={() => {}} />);
    const button = await findByRole("button");
    expect(button).toBeEnabled();
  });

  it("should be disabled if the comic is already liked", async () => {
    const { findByRole } = render(<ComicLikes isLiked={true} onLikeClick={() => {}} />);
    const button = await findByRole("button");
    expect(button).toBeDisabled();
  });

  it("calls the callback function", () => {
    const mockCallback = jest.fn();
    const { getByRole } = render(<ComicLikes isLiked={false} onLikeClick={mockCallback} />);
    const button = getByRole("button");
    fireEvent.click(button);
    expect(mockCallback.mock.calls.length).toBe(1);
  });

  it("should not call the callback function", () => {
    const mockCallback = jest.fn();
    const { getByRole } = render(<ComicLikes isLiked={true} onLikeClick={mockCallback} />);
    const button = getByRole("button");
    fireEvent.click(button);
    expect(mockCallback.mock.calls.length).toBe(0);
  });
  
  it("shows the likes count", () => {
    const mockCallback = jest.fn();
    const { getByText } = render(
      <ComicLikes 
        likes={12345678} 
        isLiked={true} 
        onLikeClick={mockCallback} />);
    const likesCount = getByText("12345678");
    expect(likesCount).toBeInTheDocument();
  });
});
