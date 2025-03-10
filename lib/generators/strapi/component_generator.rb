module Strapi
  class ComponentGenerator < Rails::Generators::Base
    source_root File.expand_path("component_templates", __dir__)

    argument :component_name, type: :string, required: true
    argument :component_type, type: :string, required: true
    class_option :strapi_params, type: :array, default: []

    COMPONENT_TYPES = %w[blocks content_blocks buttons email_content]
    PROVIDER = "providers/strapi/"
    BASE_PATH = "app/services/cms/"
    STRAPI_PATH = "#{BASE_PATH}#{PROVIDER}"
    TEST_PATH = "spec/services/cms/#{PROVIDER}"

    def setup_params
      raise StandardError unless COMPONENT_TYPES.include?(component_type)
      @component_name_class = component_name.classify
      @component_type_class = component_type.camelize
      @component_filename = component_name.underscore
      @component_type_filename = component_type.underscore
      @component_strapi_name = component_name.underscore.tr("_", "-")
      @strapi_params = options["strapi_params"]
      @rails_param_names = options["strapi_params"].map { _1.underscore }
    end

    def create_query_file
      template("query_template.rb.tt", "#{STRAPI_PATH}queries/components/#{@component_type_filename}/#{@component_filename}.rb")
    end

    def create_query_test
      template("query_test_template.rb.tt", "#{TEST_PATH}queries/components/#{@component_type_filename}/#{@component_filename}_spec.rb")
    end

    def create_mock_file
      template("mock_template.rb.tt", "#{STRAPI_PATH}mocks/dynamic_components/#{@component_type_filename}/#{@component_filename}.rb")
    end

    def create_data_file
      template("mapping_template.rb.tt", "#{BASE_PATH}dynamic_components/#{@component_type_filename}/#{@component_filename}.rb")
    end

    def run_view_component_generator
      params = @rails_param_names.join(" ").presence
      Rails::Generators.invoke(
        "component",
        ["Cms::#{@component_name_class}", params, "--test-framework=rspec", "--sidecar"].compact,
        behaviour: :invoke,
        destination_root:
      )
    rescue
      puts <<~HEREDOC
        #{"*" * 80}
        Unable to create component, please run this command seperatly

        rails generate component Cms::#{@component_name_class} #{@rails_param_names.join(" ")} --test-framework=rspec
        #{"*" * 80}

      HEREDOC
    end

    def print_method_defintions
      puts <<~HEREDOC

        #{"*" * 80}

        Remember to add the mapping method to #{STRAPI_PATH}factories/#{@component_type_filename}_factory.rb

        !! Code provided below, but may require modification depending on data types !!

        #{factory_key}
        #{"-" * 80}

        #{method_defintion}
        #{"*" * 80}

      HEREDOC
    end

    def factory_key
      <<~RUBY
        when "#{@component_strapi_name}":
          to_#{@component_filename}(strapi_data)
      RUBY
    end

    def method_defintion
      <<~RUBY
        def to_#{@component_filename}(strapi_data)
          DynamicsComponents::Blocks::#{@component_name_class}.new(
            #{@strapi_params.map { "#{_1.underscore}: strapi_data[:#{_1}]" }.join(",\n\s\s\s\s")}
          )
        end
      RUBY
    end
  end
end
