module MyExplodingRails
  class Container
    extend Dry::Container::Mixin
  end

  Container.register(:project_repo, -> { ProjectRepository.new(ROM.env) })
  Container.register(:projects_read, -> { Project::Read })

  Import = Dry::AutoInject(Container)
end
