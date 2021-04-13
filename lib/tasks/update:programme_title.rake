namespace :update do
    task programme_title: :environment do
        Programme.cs_accelerator.update_attribute(:title, 'Subject knowledge certificate')
    end 
end
