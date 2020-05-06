namespace :diagnostic do
  desc 'Cleans primary diagnostic data by resetting current_question to 4 for completed tasks'

  task reset_current_question_to_4: :environment do
    responses = QuestionnaireResponse.where(:current_question => '5')
    responses.update_all(current_question: 4)
    puts "Updated #{responses.length} responses"
  end
end
