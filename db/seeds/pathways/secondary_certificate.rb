puts 'Creating Pathways for Secondary Certificate'

programme = Programme.secondary_certificate

pathway = programme.pathways.find_or_initialize_by(slug: 'curriculum-leadership')
pathway.update(
  title: 'Curriculum leadership',
  slug: 'curriculum-leadership',
  description: 'Are you currently a Computing Lead or are looking to progress into the role? This pathway will support you to build the confidence to lead computing effectively in your school.',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf',
  programme_id: programme.id,
  order: 1
)

pathway = programme.pathways.find_or_initialize_by(slug: 'supporting-other-teachers')
pathway.update(
  title: 'Supporting other teachers',
  slug: 'supporting-other-teachers',
  description: 'Are you looking to support your colleagues through mentoring, collaborative working and sharing expertise? This pathway will help you aid your colleagues to deliver excellent computer science education to students.',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf',
  programme_id: programme.id,
  order: 1
)

pathway = programme.pathways.find_or_initialize_by(slug: 'developing-teachers')
pathway.update(
  title: 'Developing teachers',
  slug: 'developing-teachers',
  description: 'Are you looking to develop your teaching after the Early Career Framework? This pathways will support your development goals and will help increase your knowledge of the subject and pedagogy.',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf',
  programme_id: programme.id,
  order: 1
)

pathway = programme.pathways.find_or_initialize_by(slug: 'raising-student-attainment')
pathway.update(
  title: 'Raising student attainment',
  slug: 'raising-student-attainment',
  description: 'Are you looking to champion diversity and inclusion in their classrooms as well as computing as a subject? This pathway will give you knowledge of teaching interventions, encouraging girls into computer science and how to support SEND students in their learning of computing.',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf',
  programme_id: programme.id,
  order: 1
)

pathway = programme.pathways.find_or_initialize_by(slug: 'championing-diversity-and-inclusion')
pathway.update(
  title: 'Championing diversity and inclusion',
  slug: 'championing-diversity-and-inclusion',
  description: 'Are you looking to champion diversity and inclusion in their classrooms as well as computing as a subject? This pathway will give you knowledge of teaching interventions, encouraging girls into computer science and how to support SEND students in their learning of computing.',
  range: 0..0,
  pdf_link: 'https://static.teachcomputing.org/primary-pathways/Developing-in-the-Classroom.pdf',
  programme_id: programme.id,
  order: 1
)
