module NavigationHelper

  def header_navigation
		[
			{text: "Primary teachers",
			children: [
				{text: "Primary teachers", link: dashboard_path, label: "Label" }
			]},
			{text: "Secondary teachers", children:
				[{text: "Secondary teachers",
				link: dashboard_path }
			]},
			{text: "Training and support",
			children: [{text: "Training", link: dashboard_path }]},
			{text: "Teaching resources", children: [{text: "Primary teachers", link: dashboard_path }]},
			{text: "About us",
			children: [{text: "Primary teachers", link: dashboard_path }]}
		]
  end
end
