
class HelloWorld < ApplicationJob
  def perform
    puts 'Hello world'
  end
end