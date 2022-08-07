import React from "react";
import ComicLikes from './index';
import { render, fireEvent, screen } from '@testing-library/react';

describe("ComicLikes", () => {

  it("should be enabled if the comic is not liked", async () => {
    render(<ComicLikes isLiked={false} onLikeClick={() => {}} />);
    const button = await screen.findByRole("button");
    expect(button).toBeEnabled();
  });

  it("should be disabled if the comic is already liked", async () => {
    render(<ComicLikes isLiked={true} onLikeClick={() => {}} />);
    const button = await screen.findByRole("button");
    expect(button).toBeDisabled();
  });

  it("calls the callback function", () => {
    const mockCallback = jest.fn();
    render(<ComicLikes isLiked={false} onLikeClick={mockCallback} />);
    const button = screen.getByRole("button");
    fireEvent.click(button);
    expect(mockCallback.mock.calls.length).toBe(1);
  });

  it("should not call the callback function", () => {
    const mockCallback = jest.fn();
    render(<ComicLikes isLiked={true} onLikeClick={mockCallback} />);
    const button = screen.getByRole("button");
    fireEvent.click(button);
    expect(mockCallback.mock.calls.length).toBe(0);
  });
  
  it("shows the likes count", () => {
    const mockCallback = jest.fn();
    render(<ComicLikes likes={12345678} isLiked={true} onLikeClick={mockCallback} />);
    const likesCount = screen.getByText("12345678");
    expect(likesCount).toBeInTheDocument();
  });
});
