require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # Check that posts with no sub_id are invalid
  test "invalid without sub_id" do
    p = Post.new(url: "www.phonyurl.com")
    refute p.valid?, "post is valid without a sub_id"
    assert_not_nil user.errors[:url], "no validation error for url present"
  end
end
