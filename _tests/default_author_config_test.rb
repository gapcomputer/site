require 'test/unit'
require 'jekyll'

class DefaultAuthorConfigTest < Test::Unit::TestCase
  def setup
    @config = Jekyll.configuration(
      'source' => '.',
      'destination' => './_site'
    )
  end

  def test_default_author_configuration
    # Test default author configuration exists
    assert_not_nil @config['defaults'], "Defaults configuration should exist"
    
    # Check post defaults
    post_defaults = @config['defaults'].find { |default| default['scope']['type'] == 'posts' }
    assert_not_nil post_defaults, "Post defaults should be configured"
    
    # Verify default author details
    default_author = post_defaults['values']['author']
    assert_not_nil default_author, "Default author should be configured"
    
    # Check mandatory fields
    assert_not_nil default_author['name'], "Default author name should exist"
    assert_not_nil default_author['bio'], "Default author bio should exist"
    
    # Optional fields can be empty
    assert_kind_of String, default_author['avatar'], "Avatar should be a string"
    assert_kind_of String, default_author['email'], "Email should be a string"
  end
end