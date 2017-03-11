require "jrubyfx"
require "pry"

require_relative "./main_item"
require_relative "./ruby_property_binding"

java_import "javafx.application.Application"
java_import "javafx.beans.binding.Bindings"
java_import "javafx.scene.Scene"
java_import "javafx.scene.control.Label"
java_import "javafx.scene.control.TreeView"
java_import "javafx.scene.layout.AnchorPane"
java_import "javafx.stage.Stage"

class Main < JRubyFX::Application
  def start(stage)
    i1 = MainItem.new("Worlds")
    i2 = MainItem.new("Planets")

    item_group = MainItem.new("Hello")
    item_group.get_children.add_all(i1, i2)

    all_items = TreeView.new(item_group)

    some_label = Label.new

    root = AnchorPane.new
    root.get_children.add_all(all_items, some_label)

    AnchorPane.set_left_anchor(some_label, 5.0)
    AnchorPane.set_bottom_anchor(some_label, 5.0)

    ## - This looks for getBlurp in MainItem's Proxy Object and boom..
    ## - java.lang.NoSuchMethodException: org.jruby.proxy.javafx.scene.control.TreeItem$Proxy3.getBlurp()
    ## -
    # some_label.text_property.bind(Bindings.select_string(all_items.get_selection_model.selected_item_property, "blurp"))

    # - This works..
    # -
    all_items.get_selection_model.selected_item_property.add_listener(
      ->(_, _, nw) { some_label.text = "heading: #{nw.heading} (value: #{nw.value})" }
    )

    ## - Trying with Enebo's RubyPropertyBinding suggestion, a level seems to be missing at the reload_value method
    ## - https://gist.github.com/enebo/e991ee9d54fd24f69127443388b440ee
    ## -
    # some_label.text_property.bind(
    #   RubyPropertyBinding.new(
    #     property: all_items.get_selection_model.selected_item_property,
    #     method: "blurp"
    #   )
    # )

    stage.scene = Scene.new(root)
    stage.title = "Hello Universe"
    stage.show
  end
end

Main.launch
