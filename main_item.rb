require "jrubyfx"

java_import "javafx.scene.control.TreeItem"

class MainItem < TreeItem
  attr_reader :heading
  property_accessor :blurp

  def initialize(entry)
    super(entry.upcase)
    @heading = entry
    @blurp = SimpleStringProperty.new
    @blurp.set("oh look.. #{entry}")
  end
end
