# Partners API Integration

Our integration with the FutureLearn Partners API is a two step process.

- Retrieve data and update information about any users we don't have linked to our system
- Retrieve data again and update information about users progress

TeachComputing users can be linked to FutureLearn accounts in two ways. They
may have followed an invitation link, or they may have used the LTI launch tool.

A user may also enrol on different runs of the same course and may or may not drop out of those runs. They can update progress on a course indefinitely.

This means:

- A user on TeachComputing can be linked to multiple organisation memberships on FutureLearn
- A user may have multiple enrolments on the same course and we need to process the latest one to get their progress
- A user may have multiple enrolments on the same course with different organisation memberships and we need to process the latest one across accounts

This means we have to link the organisation membership IDs if we can before we process user progress.

## Update user information

The rake task `rails partners:update_memberships` is run and starts the `FutureLearn::UpdateOrganisationMembershipsJob`.

This task is run once a day, in the early hours of the morning and is scheduled via heroku.

The job does the following:

- Retrieve all course runs
- Group runs by course and check TeachComputing knows about the course
- Log the missing course if TeachComputing is not aware of it (unless the course is on a list of ignored courses)
- If TeachComputing does have the course info get all the enrolments for each course run
- Check if the organisation membership ID for each enrolment is linked to a user in our system
- If no user is linked queue the `FutureLearn::UserInformationJob`

The UserInformationJob does the following:

- Retrieve the Organisation Membership from the partners API.
- Try and match the `external_learner_id` of the membership to an email or ID in the TeachComputing database
- If there is a match add the organisation membership ID to the users `future_learn_organisation_memberships`.

## Update user progress

The rake task `rails partners:update_progress` is run and starts the `FutureLearn::CourseRunsJob`.

This task is also run once a day, and is scheduled to be run a short time after the jobs updating user information have run.
This task will not update any user information, it will only update progress for users the system recognises

The job does the following:

- Retrieve all course runs and group by course
- If the course is known to the TeachComputing system queue the `FutureLearn::CourseEnrolmentsJob`
- This job will not report missing courses as that will have been done by the user information task

The course enrolment job does the following:

- Get all enrolments for all runs of the course and group them by organisation membership
- For each member check if they have multiple organisation memberships
- If they have multiple memberships join any enrolments on this courses runs
- At this point we have a list of all users enrolled on a course linked to a list of their enrolments (which shows their progress) across all runs of a course, and across any memberships they may have
- Take the latest enrolment for a user and queue the `FutureLearn::UpdateUserActivityJob`

The update user activity job does the following:

- Find the user by their organisation membership ID
- Find or create the appropriate activity for the course
- Update the progress unless the activity is already complete
- Queue jobs to transition the primary certificate or assess eligibility for CSA where appropriate

## Performance implications

Because we have to do this two step process we end up calling the same endpoints in fairly quick succession.
There is caching in place on the API calls however so we should be pulling data from cache for the duplicate requests.

As we are running this process in the middle of the night UK time it is unlikely there will be any changes to the data between checking for user information and updating the users progress.
