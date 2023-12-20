class ChecklistImportService

  def initialize(import_params, concert)
    @import_params = import_params
    @concert = concert
    @success = false
  end

  def call
    find_template_descriptions
    build_imported_checklists if find_template_descriptions
  end

  def success
    @success
  end

  def checklist
    @checklist
  end

  private

  def find_template_descriptions
    @template_descriptions = ChecklistTemplate.find(@import_params).checklist_template_descriptions
  end

  def build_imported_checklists
    @template_descriptions.each do |template_description|
      @checklist = @concert.checklists.build(description: template_description.description)
      @success = @checklist.save
    end
  end
end
