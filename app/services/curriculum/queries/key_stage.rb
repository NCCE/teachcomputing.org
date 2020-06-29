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
    Curriculum::Request.run(ALL)
  end

  def self.one(id)
    Curriculum::Request.run(ONE, {id: id})
  end
end
