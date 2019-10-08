task programmes_sti_update: :environment do
    Programme.find_by(slug: 'cs-accelerator').update(type: 'Programmes::CSAccelerator')
    Programme.find_by(slug: 'primary-certificate').update(type: 'Programmes::PrimaryCertificate')
    Programme.find_by(slug: 'secondary-certificate').update(type: 'Programmes::SecondaryCertificate')
  end
