# Programme Objectives

I've introduced programme objectives as a new abstraction to try and standarize
how programmes are defined. We've reached the point where we have things that
are not ProgrammeActivityGroupings which need completion before the course can
be considered complete.

I've specifically chosen to not have a "ProgrammeObjective" class or concern
dispite the strong "is_a" type relationship. My reason behind this is to allow
many objects of different shapes and sizes to play this role. Especially as we
already have objects like ProgrammeActivityGroupings which play this role well.

Each item which needs completed shall be represented by an object playing the
"ProgrammeObjective" role. ProgrammeObjectives will respond to
`user_complete?(user)`.

## Progress Bar

Programme objectives that are to be displayed in the `progress_bar` will have
"objective_displayed_in_progress_bar?" return true and respond to
`progress_bar_title` and `progress_bar_path`
