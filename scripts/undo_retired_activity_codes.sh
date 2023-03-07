#! /bin/bash

# Undo retire_activity_codes.sh
bin/rails runner ./scripts/change_activity_codes.rb scripts/undo_retired_template_codes_template_uuids.tsv
