module NavigationHelper
  def header_navigation
    [
      { text: 'Primary school',
        children: [
          { text: 'Primary teacher toolkit', link: primary_teachers_path, label: 'Primary teachers' },
          { text: 'Primary certificate', link: primary_path, label: 'Primary certificate' },
          { text: 'Primary senior leaders', link: '/primary-senior-leaders', label: 'Primary SLT' }
        ] },
      { text: 'Secondary school',
        children: [
          { text: 'Secondary teacher toolkit', link: secondary_teachers_path, label: 'Secondary teachers' },
          { text: 'Subject knowledge certificate', link: cs_accelerator_path, label: 'Subject knowledge certificate' },
          { text: 'Secondary certificate', link: secondary_path, label: 'Secondary certificate' },
          { text: 'A level computer science', link: a_level_computer_science_path, label: 'A level computer science' },
          { text: 'GCSE computer science', link: gcse_revision_path, label: 'GCSE revision' },
          { text: 'Secondary senior leaders', link: '/secondary-senior-leaders', label: 'Secondary SLT' }
        ] },
      { text: 'Training and support',
        children: [
          { text: 'Courses', link: courses_path, label: 'Courses' },
          { text: 'Bursaries', link: '/bursary', label: 'Bursaries' },
          { text: 'Computing Hubs', link: '/hubs', label: 'Computing hubs' }
        ] },
      { text: 'Teaching resources',
        children: [
          { text: 'Teaching resources', link: curriculum_key_stages_path, label: 'Teaching resources' },
          { text: 'Pedagogy', link: '/pedagogy', label: 'Pedagogy' }
        ] },
      { text: 'About us',
        children: [
          { text: 'About the NCCE', link: about_path, label: 'About the NCCE' },
          { text: 'News', link: 'https://blog.teachcomputing.org/', label: 'News' },
          { text: 'Impact and evaluation', link: impact_path, label: 'Impact' },
          { text: 'Get involved', link: get_involved_path, label: 'Get involved' },
          { text: 'Gender Balance research', link: gender_balance_path, label: 'Gender Balance research' },
          { text: 'Subject practitioners', link: '/subject-practitioners', label: 'Subject practitioners' }
        ] }
    ]
  end
end
