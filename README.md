> Checking the MainItem control for `item.heading`, `item.blurp` and `item.value`..

```ruby
[1] pry(main)> item = MainItem.new("some-item")
=> #<MainItem:0x453d496b @heading="some-item", @blurp=#<Java::JavafxBeansProperty::SimpleStringProperty:0x79d743e6>>
[2] pry(main)> item.heading
=> "some-item"
[3] pry(main)> item.blurp
=> "oh look.. some-item"
[4] pry(main)> item.value
=> "SOME-ITEM"
```

> Error encountered when attempting to bind through selection_model

```bash
java.lang.NoSuchMethodException: org.jruby.proxy.javafx.scene.control.TreeItem$Proxy3.getBlurp()
```

> Error encountered when attempting ot bind through RubyPropertyBinding

```bash
#<NoMethodError: undefined method `blurp' for #<Java::JavafxBeansProperty::ReadOnlyObjectWrapper::ReadOnlyPropertyImpl:0x3847b5be>>
```
