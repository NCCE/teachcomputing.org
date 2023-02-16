namespace :activities do
  desc 'A one-off task to change the provider of all the Future Learn online activities to stem-learning'
  task make_online_stem_learning: :environment do
    Activity.online.future_learn.update_all(provider: 'stem-learning')
  end

  desc 'An approximate inverse of make_online_stem_learning to change the provider of all online STEM Learning activities to future-learn'
  task make_online_future_learn: :environment do
    Activity.online.stem_learning.update_all(provider: 'future-learn')
  end
end
