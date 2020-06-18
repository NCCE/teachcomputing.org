class Curriculum::KeyStage
  KeyStageQuery = Curriculum::Client.parse <<-'GRAPHQL'
    query {
      keyStages {
        id
        title
        description
      }
    }
  GRAPHQL

  def self.all
    response = Curriculum::Client.query(KeyStageQuery)
    if response.errors.any?
      raise QueryError.new(response.errors[:data].join(", "))
    else
      response
    end
  end
end
