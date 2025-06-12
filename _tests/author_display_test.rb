require 'jekyll'
require 'minitest/autorun'

class AuthorDisplayTest < Minitest::Test
  def setup
    @site = Jekyll::Site.new(Jekyll.configuration({
      'source' => '.',
      'destination' => './_site'
    }))
    @site.read
    @site.generate
  end

  def test_post_specific_author
    post_with_author = @site.posts.docs.find { |post| post.data['author'] }
    if post_with_author
      assert_includes post_with_author.output, "By #{post_with_author.data['author']}", 
        "Post with specific author should display author name"
    end
  end

  def test_fallback_site_author
    # Simulate a scenario with site-wide author
    @site.config['author'] = 'Site Admin'
    @site.generate
    
    post_without_author = @site.posts.docs.find { |post| !post.data['author'] }
    if post_without_author
      assert_includes post_without_author.output, "By Site Admin", 
        "Posts without author should use site-wide author"
    end
  end

  def test_anonymous_author
    # Remove site-wide author
    @site.config.delete('author')
    @site.generate
    
    post_without_author = @site.posts.docs.find { |post| !post.data['author'] }
    if post_without_author
      assert_includes post_without_author.output, "By Anonymous", 
        "Posts without author and no site-wide author should show Anonymous"
    end
  end
end