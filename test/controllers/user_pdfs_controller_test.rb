require "test_helper"

class UserPdfsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_pdf = user_pdfs(:one)
  end

  test "should get index" do
    get user_pdfs_url
    assert_response :success
  end

  test "should get new" do
    get new_user_pdf_url
    assert_response :success
  end

  test "should create user_pdf" do
    assert_difference("UserPdf.count") do
      post user_pdfs_url, params: { user_pdf: {  } }
    end

    assert_redirected_to user_pdf_url(UserPdf.last)
  end

  test "should show user_pdf" do
    get user_pdf_url(@user_pdf)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_pdf_url(@user_pdf)
    assert_response :success
  end

  test "should update user_pdf" do
    patch user_pdf_url(@user_pdf), params: { user_pdf: {  } }
    assert_redirected_to user_pdf_url(@user_pdf)
  end

  test "should destroy user_pdf" do
    assert_difference("UserPdf.count", -1) do
      delete user_pdf_url(@user_pdf)
    end

    assert_redirected_to user_pdfs_url
  end
end
