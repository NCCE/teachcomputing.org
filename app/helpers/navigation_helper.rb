module NavigationHelper

  def header_navigation
		[
			{text: "Primary teachers",
			children: [
				{text: "Primary teachers", link: dashboard_path, label: "Primary teachers" },
				{text: "Primary certificate", link: dashboard_path, label: "Primary certificate" }
			]},
			{text: "Secondary teachers", children:
				[{text: "Secondary teachers",
				link: dashboard_path, label: "" },
				{text: "Computer Science Accelerator certificate",
				link: dashboard_path, label: "" },
				{text: "Secondary certificate",
				link: dashboard_path, label: "" },
				{text: "A level computer science",
				link: dashboard_path, label: "" }
			]},
			{text: "Training and support",
			children: [
				{text: "Courses", link: dashboard_path, label: "" },
				{text: "Bursaries", link: dashboard_path, label: "" },
				{text: "Computing hubs", link: dashboard_path, label: "" },
				{text: "Case studies", link: dashboard_path, label: "" }
			]},
			{text: "Teaching resources",
			children: [
				{text: "Teaching resources", link: dashboard_path, label: "" },
				{text: "Pedagogy", link: dashboard_path, label: "" }
			]},
			{text: "About us",
			children: [
				{text: "About us", link: dashboard_path, label: "" },
				{text: "About us", link: dashboard_path, label: "" },
				{text: "About us", link: dashboard_path, label: "" },
				{text: ",About us", link: dashboard_path, label: "" },
				{text: "About us", link: dashboard_path, label: "" },
				{text: "About us", link: dashboard_path, label: "" }
			]}
		]
  end
end
