class CheckoutsController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete
end
