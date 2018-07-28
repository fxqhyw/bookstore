include Rails.application.routes.url_helpers

module Selectors
  Capybara.add_selector(:linkhref) do
    xpath { |href| ".//a[@href='#{href}']" }
  end
end
