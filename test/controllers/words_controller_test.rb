require "test_helper"

class WordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get new" do
    get new_user_word_url(@user)
    assert_response :success
  end

  test "should get create" do
    assert_difference("Word.count") do
      post user_words_url(@user), params: { word: { word: "忍者", meaning: "ninja", example: "忍者が走る", hiragana: "にんじゃ" } }
    end
    assert_redirected_to user_words_url(@user)
  end
end
