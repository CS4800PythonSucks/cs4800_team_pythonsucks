require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    #check that users have email present
  	test 'invalid email password' do
  		user = User.new(email: 'fake@example.com', encrypted_password: 'fakeperson1')
  		assert_not_nil user.errors[:email], "no email present"
  	end
end
