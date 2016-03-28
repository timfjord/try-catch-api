User.create! email: 'admin@try-catch.com', password: '123456', role: 'admin'
user1 = User.create! email: 'user1@try-catch.com', password: '123456', role: 'regular'
user2 = User.create! email: 'user2@try-catch.com', password: '123456', role: 'regular'
User.create! email: 'guest@try-catch.com', password: '123456', role: 'guest'

lazio = Team.create! name: 'SS Lazio Rome', user: [user1, user2].sample
['Federico Marchetti', 'Antonio Candreva', 'Senad Lulic', 'Stefano Mauri', 'Miroslav Klose'].each do |name|
  Player.create! name: name, team: lazio, user: [user1, user2].sample
end

dynamo = Team.create! name: 'FC Dynamo Kyiv', user: [user1, user2].sample
['Olexandr Shovkovskiy', 'Denys Garmash	', 'Oleh Gusev', 'Andriy Yarmolenko'].each do |name|
  Player.create! name: name, team: dynamo, user: [user1, user2].sample
end
