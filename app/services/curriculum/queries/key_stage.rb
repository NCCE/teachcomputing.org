class Curriculum::KeyStage
  KeyStages = Curriculum::Client.parse <<-'GRAPHQL'
    query {
      keyStages {
        id
        title
        description
      }
    }
  GRAPHQL

  def self.all
    Curriculum.request(KeyStages)
  end

  KeyStage = Curriculum::Client.parse <<-'GRAPHQL'
    query($id: ID!) {
      keyStage(id: $id) {
        id
        title
        description
      }
    }
  GRAPHQL

  def self.one(id)
    Curriculum.request(KeyStage, id)
  end
end
