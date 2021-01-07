Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    "cs_accelerator" => "CSAccelerator"
  )
end
