class JavascriptError < StandardError
  def initialize(msg)
    super(
      "Capybara intercepted a console error: #{msg}"
    )
  end
end
