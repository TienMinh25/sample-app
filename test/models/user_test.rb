require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Setup before test -> always run before test
  def setup
    @user = User.new(name: "Example Name", email: "user@example.com", password:"foobar", password_confirmation: "foobar")
  end
  # test name shoud be valid
  test "should be valid" do
    assert @user.valid?
  end
  # test name should be not blank or empty
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  # test email should be not blank or empty
  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end
  #test name shouldn't too long
  test "name should be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  # test email shouldn't too long
  test "email should be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  # test email should accept valid address
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM foo@bar.com
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be
valid"
    end
  end
  # test email should not aaccept invalid address
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org
user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should
be invalid"
    end
  end
  # test email shoud be unique -> if duplicate -> not passed
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  # test email -> before save to database, email will be converted to lowercase
  test "email address should be saved as lowercase" do
    mixed_case_email = "Foo@ExamPLE.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  # test password don't have only space (least 6 characters space)
  test "password should be present (nonblank)" do
    @user.password = " " * 6
    assert_not @user.valid?
  end

  # test password have least 6 characters
  test "password should have a minimum length" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end
end
