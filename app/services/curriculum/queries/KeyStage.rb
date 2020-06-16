module Curriculum::Query
  KeyStage = Curriculum::Client.parse <<-'GRAPHQL'
    query {
      keystage {
        id
        title
        description
      }
    }
  GRAPHQL
