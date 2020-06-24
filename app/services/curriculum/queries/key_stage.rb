class Curriculum::KeyStage
  ALL = <<~GRAPHQL
    query {
      keyStages {
        id
        title
        description
        yearGroups
      }
    }
  GRAPHQL

  ONE = <<~GRAPHQL
    query($id: ID!) {
      keyStage(id: $id) {
        id
        title
        description
        yearGroups
      }
    }
  GRAPHQL

  def self.all
    Curriculum.request(ALL)
  end

  def self.one(id)
    Curriculum.request(ONE, {id: id})
  end
end
