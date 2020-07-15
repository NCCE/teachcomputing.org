class Curriculum::Queries::BaseQuery
  def self.client
    @client ||= Curriculum::Connection.connect
  end

  def self.all(context, fields)
    all = client.parse <<~GRAPHQL
      query {
        #{context} {
          #{fields.join(' ')}
        }
      }
    GRAPHQL

    Curriculum::Request.run(all, nil, client)
  end

  def self.map_field_type(key)
    case key
    when :id.to_s
      'ID'
    when 'slug'
      'String'
    else
      raise Curriculum::Errors::UnsupportedType "No type defined for: #{key}"
    end
  end

  def self.one(context, fields, key, value)
    one = client.parse <<~GRAPHQL
      query($#{key}: #{map_field_type(key)}) {
        #{context}(#{key}: $#{key}) {
          #{fields.join(' ')}
        }
      }
    GRAPHQL

    Curriculum::Request.run(one, { "#{key}": value }, client)
  end
end
