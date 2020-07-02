class Curriculum::Queries::YearGroup
  FIELDS = ['id', 'keyStage', 'yearNumber', 'description', 'units']

  ALL = <<~GRAPHQL
    query {
      yearGroups {
        #{FIELDS.join(' ')}
      }
    }
  GRAPHQL

  ONE = <<~GRAPHQL
    query($id: ID!) {
      yearGroup(id: $id) {
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
