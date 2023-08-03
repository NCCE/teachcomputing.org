module NavigationHelper
  def header_navigation
    [
      { text: 'Primary school',
        children: [
          { text: 'Primary teacher toolkit', link: primary_teachers_path, label: 'Primary teachers' },
          { text: 'Primary computing glossary', link: '/primary-computing-glossary', label: 'School primary glossary' },
          { text: 'Primary certificate', link: primary_path, label: 'Primary certificate' },
          { text: 'Early career and trainee teachers', link: '/primary-early-careers', label: 'Primary ECT' },
          { text: 'Primary senior leaders', link: '/primary-senior-leaders', label: 'Primary SLT' }
          ] },
          { text: 'Secondary school',
            children: [
              { text: 'Secondary teacher toolkit', link: secondary_teachers_path, label: 'Secondary teachers' },
              { text: 'Subject knowledge certificate', link: cs_accelerator_path, label: 'Subject knowledge certificate' },
              { text: 'Secondary certificate', link: secondary_path, label: 'Secondary certificate' },
              { text: 'A level computer science', link: a_level_computer_science_path, label: 'A level computer science' },
              { text: 'GCSE computer science', link: gcse_revision_path, label: 'GCSE revision' },
              { text: 'Early career and trainee teachers', link: '/secondary-early-careers', label: 'Secondary ECT' },
          { text: 'Secondary senior leaders', link: '/secondary-senior-leaders', label: 'Secondary SLT' }
        ] },
      { text: 'Training and support',
        children: [
          { text: 'Courses', link: courses_path, label: 'Courses' },
          { text: 'Funding', link: '/funding', label: 'Bursaries' },
          { text: 'Computing Hubs', link: '/hubs', label: 'Computing hubs' },
          (FeatureFlagService.new.flags[:ibelong_programme_feature] ? { text: 'I Belong programme', link: '/i-belong', label: 'i-belong' } : nil),
          { text: 'Computing Clusters', link: '/computing-clusters', label: 'Computing clusters' },
        ].compact },
      { text: 'Teaching resources',
        children: [
          { text: 'Teaching resources', link: curriculum_key_stages_path, label: 'Teaching resources' },
          { text: 'Secondary question banks', link: secondary_question_banks_path, label: 'Teaching resources' },
          { text: 'Primary computing glossary', link: '/primary-computing-glossary', label: 'Resources primary glossary' },
          { text: 'Pedagogy', link: '/pedagogy', label: 'Pedagogy' }
        ] },
      { text: 'About us',
        children: [
          { text: 'About the NCCE', link: about_path, label: 'About the NCCE' },
          { text: 'News', link: 'https://blog.teachcomputing.org/', label: 'News' },
          { text: 'Impact and evaluation', link: impact_path, label: 'Impact' },
          { text: 'Get involved', link: get_involved_path, label: 'Get involved' },
          { text: 'Gender Balance research', link: gender_balance_path, label: 'Gender Balance research' }
        ] }
    ]
  end
end
