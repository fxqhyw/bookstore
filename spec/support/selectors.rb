include Rails.application.routes.url_helpers

module Selectors
  Capybara.add_selector(:linkhref) do
    xpath { |href| ".//a[@href='#{href}']" }
  end

  Capybara.add_selector(:filter_by_category) do
    xpath { |category_id| ".//a[@href='#{catalog_path(category: category_id)}']" }
  end
end
