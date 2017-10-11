# The optional locale screws with the tests; as a workaround, we set default locale for ALL specs.
# See https://github.com/rspec/rspec-rails/issues/255#issuecomment-2865917. Note that later suggestions don't work, but this earlier one does.
class ActionView::TestCase::TestController
  def default_url_options(options={})
    { :locale => I18n.default_locale }
  end
end

