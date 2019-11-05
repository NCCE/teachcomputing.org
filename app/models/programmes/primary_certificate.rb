module Programmes
  class PrimaryCertificate < Programme
    def diagnostic
      activities.find_by!(category: 'diagnostic')
    end

    def course_recommendations(user, location = Activity::ONLINE_CATEGORY)
      diagnostic_achievement = user.achievements
                                   .for_programme(self)
                                   .in_state('complete')
                                   .with_category('diagnostic')
                                   .first

      score = diagnostic_achievement.last_transition.metadata['score']

      recommendations = {
        Activity::ONLINE_CATEGORY => {
          0..9 => { title: 'Teaching Programming in Primary Schools', link: 'https://www.futurelearn.com/invitations/ncce/teaching-programming-primary-school/hqlykfbf6h3xsnvl6ejaf5r22tn064g', description: 'You might also like to consider an online course Teaching Programming in Primary Schools.  This will enable you to understand key programming concepts and apply them using Scratch.' },
          10..19 => { title: 'Programming 101: An Introduction to Python for Educators', link: 'https://www.futurelearn.com/courses/programming-101', description: 'You could consider the online Programming 101: An Introduction to Python for Educators course, which will introduce you to text based programming. During this four week programme (two hours per week), you will implement basic programming concepts and learn the basics of creating programs with Python.' },
          20..29 => { title: 'Scratch to Python: Moving from Block to Text based Programming', link: 'https://www.futurelearn.com/courses/block-to-text-based-programming', description: 'You may also be interested in the Scratch to Python: Moving from Block to Text based Programming online course.  This course will teach you how to apply the thinking and programming skills you’ve learnt in Scratch to text-based programming languages like Python.  The course is designed to take four weeks to complete, studying for 2 hour each week.' }
        },
        Activity::FACE_TO_FACE_CATEGORY => {
          0..9 => { title: 'Primary programming and algorithms', link: 'https://www.stem.org.uk/cpd/ondemand/445946/primary-programming-and-algorithms', description: 'A great place to start would be to complete the one day Primary programming and algorithms course, which will enable you to develop your understanding of programming and algorithms. You will also discover engaging ways to help pupils use computational thinking.' },
          10..19 => { title: 'Teaching and leading key stage 1 computing', link: 'href="https://www.stem.org.uk/cpd/ondemand/445953/teaching-and-leading-key-stage-1-computing', description: 'You could start with the NCCE Teaching and leading key stage 1 computing course.  Using a number of popular and accessible tools, this course will develop your confidence in delivering all aspects of the KS1 computing curriculum. You will also examine engaging ways to use technology effectively to support other areas of the curriculum.' },
          20..29 => { title: 'Teaching and leading key stage 2 computing', link: 'https://www.stem.org.uk/cpd/ondemand/445949/teaching-and-leading-key-stage-2-computing', description: 'Alternatively, you may be interested in our Teaching and leading key stage 2 computing course, which will broaden your understanding of all aspects of the KS2 computing curriculum. You will use a range of software to develop your teaching of pupils to make creative projects, in addition to enhancing your knowledge of computer systems and networks.' }
        }
      }

      recommendations[location].select { |range| range === score }.values
    end
  end
end
