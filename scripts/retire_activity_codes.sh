#! /bin/bash

# One off task to change the activity codes of 33 retired activities
bin/rails runner ./scripts/change_activity_codes.rb scripts/retired_template_codes_template_uuids.tsv
