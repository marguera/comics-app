import SearchForm from './index';
import { render, fireEvent, screen } from '@testing-library/react';

describe('SearchForm', () => {

  it('should call onSubmit when form is submitted', async () => {
    const mockCallback = jest.fn();
    render(<SearchForm onSubmit={mockCallback} />);
    const form = await screen.findByRole("form");
    fireEvent.submit(form);
    expect(mockCallback).toHaveBeenCalledTimes(1)
  });

  it('should call onSubmit with the search term', async () => {
    const mockCallback = jest.fn();
    render(<SearchForm onSubmit={mockCallback} />);
    const form = await screen.findByRole("form");
    const input = await screen.findByRole("textbox");
    fireEvent.change(input, { target: { value: '12345678' } });
    fireEvent.submit(form);
    expect(mockCallback).toHaveBeenCalledWith('12345678');
  });

  it('should clear the textfield after the submit', () => {
    const mockCallback = jest.fn();
    render(<SearchForm onSubmit={mockCallback} />);
    const form = screen.getByRole("form");
    const input = screen.getByRole("textbox");
    fireEvent.change(input, { target: { value: '12345678' } });
    fireEvent.submit(form);
    expect(input.getAttribute('value')).toBe('');
  });

  it('should have the initial placeholder value', () => {
    const mockCallback = jest.fn();
    render(<SearchForm onSubmit={mockCallback} />);
    const input = screen.getByRole("textbox");
    expect(input.getAttribute('placeholder')).toBe('Search for a character');
  });

  it('should set the placeholder value with the searched term', () => {
    const mockCallback = jest.fn();
    render(<SearchForm onSubmit={mockCallback} />);
    const input = screen.getByRole("textbox");
    const form = screen.getByRole("form");
    fireEvent.change(input, { target: { value: '12345678' } });
    fireEvent.submit(form);
    expect(input.getAttribute('placeholder')).toBe('12345678');
  });

});