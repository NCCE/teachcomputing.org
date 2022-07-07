task update_incorrect_course_data: :environment do
  courses_to_fix = %w[
    algorithms-in-gcse-computer-science
    data-and-computer-systems-in-gcse-computer-science
    networks-and-cyber-security-in-gcse-computer-science
    python-programming-essentials-for-gcse-computer-science
    introduction-to-gcse-computer-science
    python-programming-constructs-sequencing-selection-and-iteration-for-the-ocr-gcse-specification
    python-programming-constructs-sequencing-selection-and-iteration-for-the-aqa-gcse-specification
    python-programming-constructs-sequencing-selection-iteration-for-pearson-specification
  ]

  courses_to_fix.each do |slug|
    course = Activity.find_by(slug: slug)
    course.update(credit: 10)
  end

  a = Activity.find_by_slug('new-to-computing-pathway-face-to-face')
  a.update(credit: 40)
end
