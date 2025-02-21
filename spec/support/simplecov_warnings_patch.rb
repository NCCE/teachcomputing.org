module SimpleCov
  class SourceFile
    # Suggested fix from https://github.com/simplecov-ruby/simplecov/issues/1057
    #
    # this is needed for SimpleCov Issue#56
    # it also shows up for views when we `enable_coverage_for_eval`
    # patching here so that we can turn this off via ENV VAR
    def coverage_exceeding_source_warn
      return unless ENV["SHOW_EXCESS_LINE_WARNING"]

      message = "Warning: coverage data provided by Coverage [#{coverage_data["lines"].size}] "
      message += "exceeds number of lines in #{filename} [#{src.size}]"
      warn message
    end
  end
end
