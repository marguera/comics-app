import { render, screen, fireEvent } from "@testing-library/react";
import { ButtonText } from '../../definitions/ButtonText';
import Pagination from "./index";

describe("Pagination", () => {

    it("enables the prev button when prev is provided", async () => {
        render(<Pagination links={{ prev: 1 }} />);
        const prevButton = await screen.findByText(ButtonText.Previous);
        expect(prevButton).toBeEnabled();
    });

    it("disables the prev button when prev is not provided", async () => {
        render(<Pagination links={{}} />);
        const prevButton = await screen.findByText(ButtonText.Previous);
        expect(prevButton).toBeDisabled();
    });

    it("enables the next button when next is provided", async () => {
        render(<Pagination links={{ next: 2 }} />);
        const nextButton = await screen.findByText(ButtonText.Next);
        expect(nextButton).toBeEnabled();
    });

    it("disables the next button when next is not provided", async () => {
        render(<Pagination links={{}} />);
        const nextButton = await screen.findByText(ButtonText.Next);
        expect(nextButton).toBeDisabled();
    });

    it("calls the onPageChange callback when the prev button is clicked", async () => {
        const mockedOnPageChange = jest.fn();
        render(<Pagination links={{ prev: 123456 }} onPageChange={mockedOnPageChange} />);
        const nextButton = await screen.findByText(ButtonText.Previous);
        fireEvent.click(nextButton);
        expect(mockedOnPageChange).toHaveBeenCalledTimes(1);
        expect(mockedOnPageChange).toHaveBeenCalledWith(123456);
    });

    it("calls the onPageChange callback when the next button is clicked", async () => {
        const mockedOnPageChange = jest.fn();
        render(<Pagination links={{ next: 123456 }} onPageChange={mockedOnPageChange} />);
        const nextButton = await screen.findByText(ButtonText.Next);
        fireEvent.click(nextButton);
        expect(mockedOnPageChange).toHaveBeenCalledTimes(1);
        expect(mockedOnPageChange).toHaveBeenCalledWith(123456);
    });
});