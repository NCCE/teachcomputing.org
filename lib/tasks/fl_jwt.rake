task fl_jwt: :environment do
  puts FutureLearn::Connection.create_jwt
end
