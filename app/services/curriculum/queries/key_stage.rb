class Curriculum::KeyStage
  # TODO: Could this use the schema? (would need an instance of schema in)
  FIELDS = ['id', 'title', 'shortTitle', 'level', 'ages', 'description', 'yearGroups']

  ALL = <<~GRAPHQL
    query {
      keyStages {
        #{FIELDS.join(' ')}
      }
    }
  GRAPHQL

  ONE = <<~GRAPHQL
    query($id: ID!) {
      keyStage(id: $id) {
        #{FIELDS.join(' ')}
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
