RSpec.describe Rectify::Presenter do
  describe ".new" do
    it "populates attributes from a string key hash" do
      presenter = SimplePresenter.new("first_name" => "Andy", "age" => 38)

      expect(presenter).to have_attributes(
        :first_name => "Andy",
        :age => 38
      )
    end

    it "populates attributes from a symbol key hash" do
      presenter = SimplePresenter.new(:first_name => "Andy", :age => 38)

      expect(presenter).to have_attributes(
        :first_name => "Andy",
        :age => 38
      )
    end
  end

  describe "#for_controller" do
    let(:controller) { EmptyController.new }

    context "when a controller is supplied" do
      it "delegates view helper calls to `controller#view_context`" do
        presenter = SimplePresenter.new(:first_name => "Andy")
        presenter.for_controller(controller)

        expect(presenter.edit_link).to eq('<a href="edit.html">Edit Andy</a>')
      end
    end

    context "when a controller is not supplied" do
      it "raises a NoMethodError exeception" do
        presenter = SimplePresenter.new(:first_name => "Andy")

        expect { presenter.edit_link }.to raise_error(NoMethodError)
      end
    end
  end
end
