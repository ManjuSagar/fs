share_examples_for 'is invalid without the field' do |model_instance, field|
  it " #{field}" do
    model_instance.valid?;model_instance.errors[field].should be_include("can't be blank")
  end
end

share_examples_for 'is valid without the field' do |model_instance, field|
  it " #{field}" do
    model_instance.valid?;model_instance.errors[field].should be_empty
  end
end