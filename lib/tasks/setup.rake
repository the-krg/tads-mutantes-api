require 'faker'

namespace :setup do
  desc 'Sets up everything'
  task everything: :environment do
    lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
            Mauris dictum nunc nec feugiat auctor. Ut ornare velit elit, 
            id laoreet arcu ornare ut. Quisque at erat sit amet magna tincidunt 
            consectetur a sit amet lacus. Fusce maximus erat sit amet mauris malesuada, 
            in pellentesque odio tempus. Aenean ex lacus, sagittis sed aliquet non, 
            condimentum id urna. Morbi suscipit dignissim nisi, eu luctus justo. 
            Fusce ultrices metus non erat ullamcorper, id hendrerit purus fringilla. 
            Etiam semper fermentum quam, eu dapibus odio aliquet in.
            Fusce mauris eros, pretium eu massa efficitur, dictum ornare mi. 
            Duis eu congue dolor, et efficitur velit. 
            Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed non erat vehicula, 
            ultricies risus fringilla, scelerisque felis. Class aptent taciti sociosqu 
            ad litora torquent per conubia nostra, per inceptos himenaeos. 
            Ut suscipit blandit nisl, eget congue est posuere in."


    10.times do
      User.create(name: Faker::Name.name, email: Faker::Internet.email, password: '123456')
      Power.create(name: Faker::Superhero.power, description: lorem)
    end

    10.times do
      Mutant.create(name: Faker::Superhero.name, powers: [Power.all.sample], user_id: User.all.sample.id)
    end
  end
end
