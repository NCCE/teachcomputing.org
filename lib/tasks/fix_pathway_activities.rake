task fix_pathway_activities: :environment do
  PathwayActivity.delete_all

  require_relative '../../db/seeds/pathways/primary_certificate'
  require_relative '../../db/seeds/pathways/cs_accelerator'
end
