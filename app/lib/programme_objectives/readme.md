# Programme Objectives

I've introduced programme objectives as a new abstraction to try and standarize
how programmes are defined. We've reached the point where we have things that
are not ProgrammeActivityGroupings which need completion before the course can
be considered complete.

I've specifically chosen to not have a "ProgrammeObjective" class or concern
dispite the strong "is_a" type relationship. My reason behind this is to allow
many objects of different shapes and sizes to play this role. Especially as we
already have objects like ProgrammeActivityGroupings which play this role well.

Each item which needs completed shall be encapsulated in an object playing the
"ProgrammeObjective" role. ProgrammeObjectives will respond to
`user_complete?(user)`. It will also respond to
`objective_displayed_in?(location)` which can be used to decided where on the
page it should be shown.

## Progress Bar

Programme objectives that are to be displayed in the `progress_bar` must play
the role of "ProgressBarObjective" and respond to `progress_bar_title` and
`progress_bar_path`
