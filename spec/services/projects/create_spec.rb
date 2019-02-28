require 'rails_helper'

describe Projects::Create do
  describe '#validate' do
    let(:result) { subject.validate(input) }

    context 'when validation is successful' do
      let(:input) { { name: 'Test Project' } }
      let(:result) { subject.validate(input) }

      it 'returns the project parameters' do
        expect(result).to be_success
        expect(result.value!).to eq(input)
      end
    end

    context 'when validation fails' do
      let(:input) { {} }

      it 'returns validation errors' do
        expect(result).to be_failure
        expect(result.failure).to eq({name: ['is missing']})
      end
    end
  end

  describe '#persist' do
    let(:project) { double(:project) }
    let(:project_repo) { double(:project_repo) }

    subject { described_class.new(project_repo: project_repo) }

    it 'step is successful' do
      expect(project_repo).to receive(:create).with(name: 'Test Project') { project }
      subject.persist({name: 'Test Project'})
    end
  end
end
