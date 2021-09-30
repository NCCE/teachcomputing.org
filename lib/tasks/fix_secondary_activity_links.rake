task fix_secondary_activity_links: :environment do
  a = Activity.find_by_slug('answer-5-questions-on-isaac-computer-science')
  a.update(description: "<a href='https://isaaccomputerscience.org/teachers' class='ncce-link'>Log in or register for Isaac Computer Science</a> and <a href='https://isaaccomputerscience.org/topics' class='ncce-link'>answer any 5 questions from across the topic sections. <a href='https://isaaccomputerscience.org/progress' class='ncce-link'>Screenshot your progress dashboard</a> as evidence you have completed this activity.")

  a = Activity.find_by_slug('engage-with-stem-ambassadors')
  a.update(description: '<a href="https://www.stem.org.uk/stem-ambassadors/inspiration/activities" class="ncce-link">Register for STEM ambassadors</a> and complete a visit, or any other meaningful engagement')
end
