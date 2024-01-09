# These courses exist on the preprod instance of Dynamics for testing: so they are visible on
# the preprod Smart Connector (Achiever)

cs_accelerator = Programme.cs_accelerator
primary_certificate = Programme.primary_certificate
secondary_certificate = Programme.secondary_certificate

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "f5fe2274-fdb1-ed11-83ff-0022481b547a") do |activity|
  activity.title = "NCCE Online Course 1"
  activity.credit = 20
  activity.slug = "ncce-online-course-1"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "OC123"
  activity.always_on = true
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "616b340e-ffb1-ed11-83ff-0022481b547a") do |activity|
  activity.title = "NCCE Online Course 2"
  activity.credit = 20
  activity.slug = "ncce-online-course-2"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "OC2879"
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "94196e7f-47b8-ed11-b597-0022481b547a") do |activity|
  activity.title = "NCCE Online Course 3"
  activity.credit = 20
  activity.slug = "ncce-online-course-3"
  activity.category = "online"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "OCT"
  activity.always_on = true
end

a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

########################################################################################################################

a = Activity.find_or_create_by(stem_course_template_no: "f3f69e74-11b9-ed11-b597-0022481b5082") do |activity|
  activity.title = "NCCE F2F Course"
  activity.credit = 10
  activity.slug = "ncce-f2f-course"
  activity.category = "face-to-face"
  activity.provider = "stem-learning"
  activity.stem_activity_code = "OC124"
  activity.always_on = false
end

########################################################################################################################
