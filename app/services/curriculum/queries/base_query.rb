class Curriculum::Queries::BaseQuery
  def self.client
    @client ||= Curriculum::Connection.connect
  end

  def self.all(context, fields)
    all = <<~GRAPHQL
      query {
        #{context} {
          #{fields}
        }
      }
    GRAPHQL

    Curriculum::Request.run(client.parse(all), client)
  end

  def self.map_field_type(key)
    case key
    when :id
      'ID'
    when :slug
      'String'
    else
      raise Curriculum::Errors::UnsupportedType "No type defined for: #{key}"
    end
  end

  def self.one(context, fields, key, value)
    one = <<~GRAPHQL
      query($#{key}: #{map_field_type(key)}) {
        #{context}(#{key}: $#{key}) {
          #{fields}
        }
      }
    GRAPHQL

    Curriculum::Request.run(client.parse(one), client, { "#{key}": value })
  end

  def self.rate(context, fields, polarity, id)
    rating = <<~GRAPHQL
      mutation {
        add#{polarity.to_s.classify}#{context.to_s.classify}Rating(
          id: "#{id}"
        )
        {
          #{fields}
        }
      }
    GRAPHQL

    Curriculum::Request.run(client.parse(rating), client)
  end
end
