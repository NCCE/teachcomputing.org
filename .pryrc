Pry.commands.alias_command "c", "continue"
Pry.commands.alias_command "s", "step"
Pry.commands.alias_command "n", "next"

if Pry::Prompt[:rails]
  Pry.config.prompt = Pry::Prompt[:rails]
end
