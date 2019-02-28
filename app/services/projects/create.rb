module Projects
  class Create
    include Dry::Transaction
    include MyExplodingRails::Import['project_repo']

    step :read
    map :persists

    def call(data)
      validated_data = yield validate(data)

      persists(validated_data)
    end

    def validate(input)
      validation = ProjectSchema.call(input)
      if validation.success?
        Success(input)
      else
        Failure(validation.errors)
      end
    end

    def persists(input)
      project = project_repo.create(input)
    end
  end
end
