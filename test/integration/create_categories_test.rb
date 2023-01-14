require "test_helper"
# require "rails-controller-testing"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new category from and create category" do
    get new_category_path
    assert_template 'categories/new'
    assert_difference "Category.count", 1 do
      post "/categories",
      params: { category: { name: "books" } }
    end
    assert_redirected_to category_url(Category.last)
    follow_redirect!
    assert_response :success
    assert_select "h1", "Category"
  end

  test "invalid category submission results in failure" do
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_url,
      params: { category: { name: "" } }
    end
    assert_template "categories/new"
    assert_select 'h2.card-title'
    assert_select 'div.card-body'
  end
end
