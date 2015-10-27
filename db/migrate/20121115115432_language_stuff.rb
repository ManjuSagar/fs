class LanguageStuff < ActiveRecord::Migration
  def up
    change_column :languages, :language_code, :string, :limit => 2, :null => false
    change_column :languages, :language_description, :string, :limit => 50, :null => false

    remove_column :treatment_requests, :preferred_language
    add_column :treatment_requests, :preferred_language_id, :integer

    Language.destroy_all
    Language.create(language_code: "EN", language_description: "English")
    Language.create(language_code: "SP", language_description: "Spanish")
    Language.create(language_code: "C1", language_description: "Chinese: Mandarin")
    Language.create(language_code: "C2", language_description: "Chinese: Cantonese")
    Language.create(language_code: "IT", language_description: "Italian")
    Language.create(language_code: "FR", language_description: "French")
  end

  def down
  end
end
