class Curriculum::Queries::Unit
  FIELDS = ['id', 'description', 'unitOverview', 'lessons']

  ALL = <<~GRAPHQL
    query {
      units{
        #{FIELDS.join(' ')}
      }
    }
  GRAPHQL

  ONE = <<~GRAPHQL
    query($id: ID!) {
      unit(id: $id) {
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
