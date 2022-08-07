import React from "react";
import App from "./App";
import { render, screen } from "@testing-library/react";

describe("App", () => {

  it("should render without crashing", () => {
    const { container } = render(<App />);
    expect(container).toBeInTheDocument();
  })

  it("should render the header", () => {
    render(<App />);
    expect(screen.getByRole("banner")).toBeInTheDocument();
  })

  it("should render the search form", () => {
    render(<App />);
    expect(screen.getByRole("form")).toBeInTheDocument();
  })
});