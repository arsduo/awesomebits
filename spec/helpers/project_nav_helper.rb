require 'spec_helper'
require 'date'

describe ProjectNavHelper do

  context 'next_link' do
    let(:chapter) { FactoryGirl.create :chapter, :name => 'Test chapter' }
    let!(:project) { FactoryGirl.create :project, :chapter => chapter, :funded_on => Date.today + 1 }
   # let!(:second_project) { FactoryGirl.create :project, :chapter => chapter, :funded_on => Date.today } # отрефакторить

    it 'Единственный проект не может иметь ссылки на следующий' do
      expect(helper.next_project_id project).to be_nil
    end

    it 'Первый проект имеет сслыку next_project на 2й проект' do
      second_project = FactoryGirl.create :project, :chapter => chapter, :funded_on => Date.today
      expect(helper.next_project_id project).to eq(second_project.id)
    end

    it 'Последний проект не может иметь следующего' do
      second_project = FactoryGirl.create :project, :chapter => chapter, :funded_on => Date.today
      expect(helper.next_project_id second_project).to be_nil
    end
  end

  context 'prev_link' do
    let(:chapter) { FactoryGirl.create :chapter, :name => 'Test chapter' }
    let!(:project) { FactoryGirl.create :project, :chapter => chapter, :funded_on => Date.today + 1 }
    let!(:second_project) { FactoryGirl.create :project, :chapter => chapter, :funded_on => Date.today }

    it 'Единственный проект не может иметь ссылки на предыдущий' do
      expect(helper.prev_project_id project).to be_nil
    end

    it 'Второй проект имеет сслыку prev_project на 1й проект' do
      expect(helper.prev_project_id second_project).to eq(project.id)
    end

    it 'Первый проект не может иметь prev_project ссылки' do
      expect(helper.prev_project_id project).to be_nil
    end
  end

  context 'private methods' do
    let(:chapter) { FactoryGirl.create :chapter, :name => 'Test chapter' }
    let!(:first_project) { FactoryGirl.create :project, :chapter => chapter, :funded_on => Date.today + 1 }
    let!(:last_project) { FactoryGirl.create :project, :chapter => chapter, :funded_on => Date.today }

    context 'is_first_project?' do
      it 'Первый проект является первым' do
        expect(helper.send(:is_first_project?, first_project)).to be_truthy
      end

      it 'Последний проект не является первым' do
        expect(helper.send(:is_first_project?, last_project)).to be_falsey
      end
    end

    context 'is_last_project?' do
      it 'Последний проект является последним' do
        expect(helper.send(:is_last_project?, last_project)).to be_truthy
      end

      it 'Последний проект не является первым' do
        expect(helper.send(:is_last_project?, first_project)).to be_falsey
      end
    end

    context 'chapter_projects_keys' do
      it 'Правильная сортировка ключей в методе chapter_projects_keys' do
        expect(helper.send(:chapter_projects_keys, first_project)).to eq([first_project.id, last_project.id])
      end
    end
  end
end