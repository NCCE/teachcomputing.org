module NavigationHelper
  def header_navigation
    [
      {text: "Primary",
       children: [
         {text: "Teacher toolkit", link: primary_teachers_path, label: "Primary teachers"},
         {text: "Teacher certificate", link: primary_path, label: "Primary teacher certificate"},
         {text: "Early career and trainee teachers", link: "/primary-early-careers", label: "Primary ECT"},
         {text: "Senior leaders", link: "/primary-senior-leaders", label: "Primary SLT"},
         {text: "Enrichment", link: primary_enrichment_path, label: "Enrichment"}
       ]},
      {text: "Secondary",
       children: [
         {text: "Teacher toolkit", link: secondary_teachers_path, label: "Secondary teachers"},
         {text: "Teacher certification", link: secondary_certification_path, label: "Secondary teachers certification"},
         {text: "Enrichment", link: secondary_enrichment_path, label: "Enrichment"},
         {text: "Early career and trainee teachers", link: "/secondary-early-careers", label: "Secondary ECT"},
         {text: "Senior leaders", link: "/secondary-senior-leaders", label: "Secondary SLT"}
       ].compact},
      {text: "Training and support",
       children: [
         {text: "Courses", link: courses_path, label: "Courses"},
         {text: "Funding", link: "/funding", label: "Bursaries"},
         {text: "Computing Hubs", link: "/hubs", label: "Computing hubs"},
         {text: "I Belong programme", link: "/i-belong", label: "i-belong"},
         {text: "GCSE Computer Science support", link: "/gcse-cs-support", label: "GCSE support"},
         {text: "Computing Clusters", link: "/computing-clusters", label: "Computing clusters"},
         {text: "School Trusts", link: "/school-trusts", label: "School trusts"}
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
