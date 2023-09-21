desc 'Takes users in the old primary pathways and moves them to new ones'
task migrate_old_primary_pathways: :environment do
  old_developing = Pathway.find_by(slug: 'developing-in-the-classroom')
  new_developing = Pathway.find_by(slug: 'developing-in-the-classroom-2')
  old_specialising = Pathway.find_by(slug: 'specialising-or-leading')
  new_specialising = Pathway.find_by(slug: 'specialising-or-leading-2')

  UserProgrammeEnrolment
    .where(pathway: old_developing)
    .update_all(pathway_id: new_developing.id, message_flags: { primary_pathway_migrated: true })

  UserProgrammeEnrolment
    .where(pathway: old_specialising)
    .update_all(pathway_id: new_specialising.id, message_flags: { primary_pathway_migrated: true })
end
