task invalidate_cached_schema: :environment do
  Rails.cache.delete("curriculum_schema")
end
