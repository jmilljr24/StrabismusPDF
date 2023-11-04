require "application_system_test_case"

class UserPdfsTest < ApplicationSystemTestCase
  setup do
    @user_pdf = user_pdfs(:one)
  end

  test "visiting the index" do
    visit user_pdfs_url
    assert_selector "h1", text: "User pdfs"
  end

  test "should create user pdf" do
    visit user_pdfs_url
    click_on "New user pdf"

    click_on "Create User pdf"

    assert_text "User pdf was successfully created"
    click_on "Back"
  end

  test "should update User pdf" do
    visit user_pdf_url(@user_pdf)
    click_on "Edit this user pdf", match: :first

    click_on "Update User pdf"

    assert_text "User pdf was successfully updated"
    click_on "Back"
  end

  test "should destroy User pdf" do
    visit user_pdf_url(@user_pdf)
    click_on "Destroy this user pdf", match: :first

    assert_text "User pdf was successfully destroyed"
  end
end
