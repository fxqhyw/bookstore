module CheckoutsHelper
  def active_step(current_step)
    'active' if current_step == step
  end
end
