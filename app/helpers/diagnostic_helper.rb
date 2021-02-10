module DiagnosticHelper
  def step_index(steps, step)
    steps.index(step) + 1
  end

  def current_position(steps, step)
    "Question #{step_index(steps, step)} of #{steps.count}"
  end

  def cs_accelerator_questions(question)
    shared_answers = [
      {
        text: 'Not at all confident',
        value: 1
      },
      {
        text: 'A little confident',
        value: 2
      },
      {
        text: 'Fairly confident',
        value: 3
      },
      {
        text: 'Very confident',
        value: 4
      }
    ]

    questions = {
      question_1: {
        text: 'What is your computer science curriculum subject knowledge confidence level?',
        answers: [
          {
            text: 'Not at all confident',
            value: 1
          },
          {
            text: 'Confident up to KS3',
            value: 2
          },
          {
            text: 'Confident up to KS4',
            value: 3
          },
          {
            text: 'Confident teaching beyond KS4',
            value: 4
          }
        ],
        default_answer: 1
      },
      question_2: {
        text: 'How confident are you that you could create a simple program which uses sequence,
               selection (e.g. if), iteration (e.g. for loop) and define your own functions',
        answers: shared_answers,
        default_answer: 1
      },
      question_3: {
        text: 'How confident are you that you could describe the components of a computer system or
               lead a debate on the ethical considerations of the use of technology? e.g. describe
               the difference between storage and memory?',
        answers: shared_answers,
        default_answer: 1
      },
      question_4: {
        text: 'How confident are you that you could compare different algorithms e.g. how the merge sort
               algorithm compares to bubble sort?',
        answers: shared_answers,
        default_answer: 1
      },
      question_5: {
        text: 'How confident are you in your networking knowledge? e.g. could describe what DNS is and
               what it does?',
        answers: shared_answers,
        default_answer: 1
      }
    }

    JSON.parse questions[question].to_json, object_class: OpenStruct
  end

  def primary_certificate_questions(question)
    shared_answers = [
      {
        text: 'Not at all confident',
        value: 5
      },
      {
        text: 'A little confident',
        value: 10
      },
      {
        text: 'Fairly confident',
        value: 15
      },
      {
        text: 'Very confident',
        value: 20
      }
    ]

    questions = {
      question_1: {
        text: 'How confident are you teaching the programming elements of the KS1 and KS2 Computing
               National Curriculum?',
        sub_text: 'For example, are you able to explain the concepts of algorithms
                  and computational thinking to pupils?',
        answers: shared_answers,
        default_answer: 1
      },
      question_2: {
        text: 'How confident are you in effectively teaching the whole of the KS1 Computing National
              Curriculum?',
        sub_text: 'For example, are you familiar with common uses of technology beyond school,
                  or how pupils can use technology to develop digital content?',
        answers: shared_answers,
        default_answer: 1
      },
      question_3: {
        text: 'How confident are you in effectively teaching the whole of the KS2 Computing National Curriculum?',
        sub_text: 'For example, are you able to develop pupils’ understanding of computer networks, including the
                  Internet, or how to support children in developing a range of programs, systems and content,
                  using digital devices?',
        answers: shared_answers,
        default_answer: 1
      },
      question_4: {
        text: 'How confident are you that you can support pupils to go beyond the requirements of the KS2
              computing national curriculum, such as through introducing text based programming?',
        answers: shared_answers,
        default_answer: 1
      }
    }

    JSON.parse questions[question].to_json, object_class: OpenStruct
  end
end
