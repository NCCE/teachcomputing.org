class BasePresenter < SimpleDelegator
  attr_reader :view

  def initialize(model, view)
    @view = view
    super(model)
  end
end
