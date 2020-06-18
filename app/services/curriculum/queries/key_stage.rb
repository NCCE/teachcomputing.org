class Curriculum::KeyStage
  def self.all
    request = Curriculum.connect
    keyStage = request.parse <<-'GRAPHQL'
      query {
        keyStages {
          id
          title
          description
        }
      }
    GRAPHQL
  end
end
