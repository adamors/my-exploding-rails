module Projects
  class Create
    include Dry::Transaction
    include MyExplodingRails::Import['project_repo']

    step :validate
    map :persist

    def validate(input)
      validation = ProjectSchema.call(input)
      if validation.success?
        Success(input)
      else
        Failure(validation.errors)
      end
    end

    def persist(input)
      project = project_repo.create(input)
    end
  end
end
