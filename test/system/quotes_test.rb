require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  def setup
    @quote = quotes(:first) #Reference to the first fixture quote    
  end
  
  test "creating a new quote" do
    # When we visit the Quotes#index page
    # we expect to see a title with the text "Quotes"
    get quotes_path
    assert_selector "h1", text: "Quotes"
    
    # When we click on the link with the text "New quote"
    # we expect to land on a page with the title "New quote"
    click_on "New quote"
    assert_selector "h1", text: "New quote"

    # When we fill in the name input with "Capybara quote"
    # and we click on "Create Quote"
    fill_in "Name", with: "Capybara quote"
    click_on "Create quote"

    # We expect to be back on the page with the title "Quotes"
    # and to see our "Capybara quote" added to the list
    assert_selector "h1", text: "Quotes"
    assert_text "Capybara quote"

    test "showing a quote" do
      visit quotes_path
      click_on quote.name

      assert_selector "h1", text: quote.name
    end
  end

  test "updating a quote" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    click_on "Edit", match: :first
    assert_selector "h1", text: "Edit quotes"

    fill_name "Name", with: "Updated quote"
    click_on "Update quote"

    assert_selector "h1", text: "Quotes"
    assert_text "Updated quote"
  end

  test "destroying a quote" do 
    visit quotes_path
    assert_text quote.name

    click_on "Delete", match: :first
    assert_no_text @quote.name
  end
end
