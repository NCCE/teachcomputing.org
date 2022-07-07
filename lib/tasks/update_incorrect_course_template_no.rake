task update_incorrect_course_template_no: :environment do
  a = Activity.find_by(slug: 'new-to-computing-pathway-face-to-face')
  a.update(stem_course_template_no: '695862e6-6578-ec11-8d21-000d3a0cb2ab')
end
