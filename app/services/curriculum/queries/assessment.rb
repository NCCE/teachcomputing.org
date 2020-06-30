class Curriculum::Assessment
  FIELDS = ['id', 'unit', 'title', 'description', 'rubric', 'summative_assessment', 'sheets']

  ALL = <<~GRAPHQL
    query {
      assessments {
        #{FIELDS.join(' ')}
      }
    }
  GRAPHQL

  ONE = <<~GRAPHQL
    query($id: ID!) {
      assessment(id: $id) {
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
