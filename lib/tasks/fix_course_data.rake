desc 'updates course data'
task update_course_data: :environment do
  p = Programme.cs_accelerator

  p.activities.find_by(slug: 'programming-with-python-–-intensive-cpd').update(
    title: 'Programming with Python - intensive CPD',
    slug: 'programming-with-python-intensive-cpd'
  )

  p.activities.find_by(slug: 'preparing-to-teach-gcse-computer-science-–-intensive-cpd').update(
    title: 'Preparing to teach GCSE computer science - intensive CPD',
    slug: 'preparing-to-teach-gcse-computer-science-intensive-cpd'
  )

  p.activities.find_by(slug: 'supporting-student-attainment-in-gcse-computer-science-–-intensive-cpd').update(
    title: 'Supporting student attainment in GCSE computer science - intensive CPD',
    slug: 'supporting-student-attainment-in-gcse-computer-science-intensive-cpd'
  )
end
