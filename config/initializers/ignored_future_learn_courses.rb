# When retrieving user progress updates from the FutureLearn Partners API
# there are some courses that do not exist in our system and do not need to
# IDs of these courses will be added to an environment variable and we create a
# constant here to access them in jobs

str = ENV['FL_PARTNERS_IGNORED_COURSE_UUIDS'] || ''

FL_PARTNERS_IGNORED_COURSE_UUIDS = str.split(',')
