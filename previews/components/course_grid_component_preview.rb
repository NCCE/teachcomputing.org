class CourseGridComponentPreview < ViewComponent::Preview
  def default
    course_grid_config = {
      title: "A title goes here",
      intro: "Some intro text here",
      event_category: "Primary teacher",
      courses: [
        {
          image: "media/images/pages/secondary-toolkit/python_programming.jpeg",
          image_alt: "STEM course",
          title: "Python programming constructs for OCR specification",
          url: "/courses/CP423A/python-programming-constructs-sequencing-selection-iteration-for-ocr-specification",
          description: "Learn how to write code to input, process and output data, and how to manipulate data stored in variables.",
          icon_class: "icon-remote",
          type: "Live remote",
          time_commitment: "6 hours",
          event_label: "CP423A"
        },
        {
          image: "media/images/pages/secondary-toolkit/supporting_gcse.png",
          image_alt: "STEM course",
          title: "Supporting GCSE computer science students at grades 1 to 3",
          url: "/courses/CP478/supporting-gcse-computer-science-students-at-grades-1-3",
          description: "This evidence-based CPD explores how to improve attainment in Computer Science for students working towards grades 1 to 3.",
          icon_class: "icon-remote",
          type: "Live remote",
          time_commitment: "6 hours",
          event_label: "CP478"
        }
      ]
    }

    render CourseGridComponent.new(**course_grid_config)
  end
end
