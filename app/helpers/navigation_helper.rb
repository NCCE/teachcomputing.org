module NavigationHelper
  def header_navigation
    [
      {text: "Primary",
       children: [
         {text: "Subject lead toolkit", link: primary_teachers_path, label: "Subject lead toolkit"},
         {text: "Teacher certificate", link: cms_page_path("primary-certificate"), label: "Primary teacher certificate"},
         {text: "Enrichment", link: primary_enrichment_path, label: "Enrichment"},
         {text: "Early career teachers", link: cms_page_path("primary-early-careers"), label: "Primary ECT"},
         {text: "Trainee teachers", link: cms_page_path("primary-trainees"), label: "Primary Trainees"},
         {text: "Senior leaders", link: primary_senior_leaders_path, label: "Primary SLT"}
       ]},
      {text: "Secondary",
       children: [
         {text: "Teacher toolkit", link: secondary_teachers_path, label: "Secondary teachers"},
         {text: "Teacher certification", link: secondary_certification_path, label: "Secondary teachers certification"},
         {text: "Enrichment", link: secondary_enrichment_path, label: "Enrichment"},
         {text: "Early career teachers", link: cms_page_path("secondary-early-careers"), label: "Secondary ECT"},
         {text: "Trainee teachers", link: cms_page_path("secondary-trainees"), label: "Secondary Trainees"},
         {text: "Senior leaders", link: secondary_senior_leaders_path, label: "Secondary SLT"}
       ].compact},
      {text: "Training and support",
       children: [
         {text: "Courses", link: courses_path, label: "Courses"},
         {text: "I Belong programme", link: about_i_belong_path, label: "i-belong"},
         {text: "GCSE Computer Science support", link: cms_page_path("gcse-cs-support"), label: "GCSE support"},
         {text: "School Trusts", link: cms_page_path("school-trusts"), label: "School trusts"}
       ]},
      {text: "Teaching resources",
       children: [
         {text: "Teaching resources", link: curriculum_key_stages_path, label: "Teaching resources"},
         {text: "Isaac Computer Science", link: about_isaac_computer_science_path, label: "Isaac Computer Science"},
         {text: "Careers support", link: careers_support_path, label: "Careers support"},
         {text: "Secondary question banks", link: secondary_question_banks_path, label: "Teaching resources"},
         {text: "Artificial Intelligence", link: cms_page_path(page_slug: "artificial-intelligence"), label: "Artificial Intelligence"},
         {text: "Pedagogy", link: cms_page_path(page_slug: "pedagogy"), label: "Pedagogy"},
         {text: "Primary computing glossary", link: cms_page_path(page_slug: "primary-computing-glossary"), label: "Resources primary glossary"},
         {text: "Physical computing kits", link: cms_page_path("physical-computing-kit"), label: "Physical computing kits"}
       ]},
      {text: "About us",
       children: [
         {text: "About the NCCE", link: about_path, label: "About the NCCE"},
         {text: "News", link: cms_posts_path, label: "News"},
         {text: "Impact and evaluation", link: impact_path, label: "Impact"},
         {text: "Get involved", link: get_involved_path, label: "Get involved"}
       ]}
    ]
  end
end
